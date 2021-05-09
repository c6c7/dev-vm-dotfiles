;; This is an operating system configuration generated
;; by the graphical installer.

(use-modules (gnu))
(use-service-modules desktop networking ssh xorg)

(operating-system
  (locale "en_US.utf8")
  (timezone "America/Los_Angeles")
  (keyboard-layout (keyboard-layout "us" "colemak"))
  (host-name "space-needle")
  (users (cons* (user-account
                  (name "chcl")
                  (comment "Charles Celerier")
                  (group "users")
                  (home-directory "/home/chcl")
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
			 `(("chcl" ,(local-file "/home/chcl/.ssh/guix-allowed-keys/macbook-air-2020.pub"))))))
            (service dhcp-client-service-type))
      %base-services))
  (bootloader
    (bootloader-configuration
      (bootloader grub-bootloader)
      (target "/dev/sda")
      (keyboard-layout keyboard-layout)))
  (swap-devices
    (list (uuid "33ed5682-c045-4e11-a952-5fbe38820841")))
  (file-systems
    (cons* (file-system
             (mount-point "/")
             (device
               (uuid "3674e568-9a1d-45ed-bf71-6c28c13a4db3"
                     'ext4))
             (type "ext4"))
           (file-system
             (mount-point "/home")
             (device
               (uuid "33098d80-e20a-4964-8723-646fbbf9bf17"
                     'ext4))
             (type "ext4"))
           %base-file-systems)))
