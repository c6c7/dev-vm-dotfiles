(cons* (channel
        (name 'flat)
        (url "https://github.com/flatwhatson/guix-channel.git")
        (introduction
         (make-channel-introduction
          "33f86a4b48205c0dc19d7c036c85393f0766f806"
          (openpgp-fingerprint
           "736A C00E 1254 378B A982  7AF6 9DBE 8265 81B6 4490"))))
       (channel
        (name 'chckyn)
        (url "https://github.com/chckyn/guix-channel.git")
        (branch "main")
        (introduction
         (make-channel-introduction
          "daa642fbaa53e9b6f1cfd22ea013e5fdf4e17e3a"
          (openpgp-fingerprint
           "2116 4C25 323C EAF7 611E  49E6 9CFB 4F28 C311 D53D"))))
       (channel
        (name 'nonguix)
        (url "https://gitlab.com/nonguix/nonguix")
        ;; Enable signature verification:
        (introduction
         (make-channel-introduction
          "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
          (openpgp-fingerprint
           "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
       %default-channels)
