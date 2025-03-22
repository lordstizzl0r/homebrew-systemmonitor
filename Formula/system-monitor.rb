class SystemMonitor < Formula
    desc "Electron-App zur Überwachung von Systemressourcen"
    homepage "https://github.com/lordstizzl0r/system-monitor"
    url "https://github.com/lordstizzl0r/system-monitor/archive/v1.0.0.tar.gz"
    sha256 "REPLACE_WITH_ACTUAL_SHA256_CHECKSUM"
    license "MIT"
    
    depends_on "node"
    depends_on "ffmpeg"
    
    def install
      system "npm", "install", "--production"
      system "npm", "run", "build"
      
      libexec.install Dir["*"]
      
      # Erstelle einen Symlink für das Programm
      bin.install_symlink libexec/"System Monitor"
      
      # Erstelle eine .app-Datei für macOS
      (prefix/"System Monitor.app").write <<~EOS
        #!/bin/bash
        open "#{libexec}/System Monitor"
      EOS
      chmod 0755, "#{prefix}/System Monitor.app"
    end
  
    def caveats
      <<~EOS
        System Monitor wurde installiert.
        
        Du kannst die Anwendung starten mit:
          open "#{libexec}/System Monitor.app"
        
        Oder über das Launchpad.
      EOS
    end
    
    test do
      # Füge hier Tests hinzu
      system "#{bin}/System Monitor", "--version"
    end
  end