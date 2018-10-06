bind:
  pkg.installed:
    - names:
      - bind9
      - bind9-host
      - bind9utils
  service.running:
    - name: bind9
    - enable: True
    - reload: True
    - watch:
      - file: /lib/systemd/system/bind9.service
      - file: /etc/bind/named.conf.options
    - require:
      - pkg: bind9
      - pkg: openvpn
      - service: S40network


/lib/systemd/system/bind9.service:
  file.managed:
    - source: salt://bind/lib/systemd/system/bind9.service
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: systemd
      - pkg: bind9

/etc/bind/named.conf.options:
  file.managed:
    - source:
      - salt://bind/etc/bind/named.conf.options
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: bind

/etc/bind/openvpn.forwarder:
  file.managed:
    - source:
      - salt://bind/etc/bind/openvpn.forwarder
    - user: root
    - group: root
    - mode: 644
    - replace: false
    - require:
      - pkg: bind

/var/log/named:
  file.directory:
    - user: bind
    - group: bind
    - require:
      - pkg: bind
