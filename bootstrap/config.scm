;; This is an operating system configuration generated
;; by the graphical installer.

(use-modules (gnu))
(use-service-modules desktop networking ssh xorg)

(operating-system
  (locale "en_US.utf8")
  (timezone "America/Los_Angeles")
  (keyboard-layout (keyboard-layout "us" "colemak"))
  (host-name "pike-place")
  (users (cons* (user-account
                  (name "c")
                  (comment "Charles Celerier")
                  (group "users")
                  (home-directory "/home/c")
                  (supplementary-groups
                    '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))
  (packages
    (append
      (list (specification->package "nss-certs"))
      %base-packages))
  (services
    (append
      (list (service openssh-service-type
		     (openssh-configuration
		       (x11-forwarding? #f)
		       (permit-root-login #f)
		       (allow-empty-passwords? #t)
		       (authorized-keys
			 `(("c" ,(local-file "/home/ec2-user/dev-vm-dotfiles/bootstrap/macbook-air-2020.pub"))))))
            (service dhcp-client-service-type))
      %base-services))
  (bootloader
    (bootloader-configuration
      (bootloader grub-bootloader)
      (target "/boot/efi")
      (keyboard-layout keyboard-layout)))
  (swap-devices
    (list (file-system-label "swap")))
  (file-systems
    (cons* (file-system
             (mount-point "/")
             (device (file-system-label "root"))
             (type "ext4"))
           (file-system
             (mount-point "/home")
             (device (file-system-label "home"))
             (type "ext4"))
           %base-file-systems)))
