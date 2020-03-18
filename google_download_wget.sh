#!/bin/bash
# https://productforums.google.com/forum/#!topic/docs/bbug4rzRvu8
# https://stackoverflow.com/questions/10730712/download-unpublished-google-spreadsheet-as-csv
# or wget -N --content-disposition
SD="$(cd "$(dirname "$0")" > /dev/null || exit 1; pwd)";
cd "$SD" || exit 1

cpx() { PROXYCHAINS_CONF_FILE=$XDG_CONFIG_HOME/proxychains.conf proxychains -q wget --no-use-server-timestamps --no-if-modified-since --content-disposition "$@"; }

list=(
  #"https://docs.google.com/document/export?format=odt&id=14ggeAyXvGGWM_R-v-UJvPXGBwllUyH_1lxiLnRUMiso"
  # Pomf Clones and File Hosting Comparisons
  # https://docs.google.com/spreadsheets/d/1vrKixs_ItQlLnGK6_D22qP3NhRPiD8n7SATX81CGzzs/edit#gid=0
  "https://docs.google.com/spreadsheets/d/1vrKixs_ItQlLnGK6_D22qP3NhRPiD8n7SATX81CGzzs/export?format=ods&id=1vrKixs_ItQlLnGK6_D22qP3NhRPiD8n7SATX81CGzzs"
  # FAQ сексача
  # https://docs.google.com/document/d/1lS0xEt2-UGY9nDF5E6N4In-mafdPgKH0KjyypBuMeLs/edit
  "https://docs.google.com/document/export?format=odt&id=1lS0xEt2-UGY9nDF5E6N4In-mafdPgKH0KjyypBuMeLs"
  # Tracker Tracker
  # https://docs.google.com/spreadsheets/d/1zYZ2107xOZwQ37AjLTc5A4dUJl0ilg8oMrZyA0BGvc0/edit
  "https://docs.google.com/spreadsheets/d/1zYZ2107xOZwQ37AjLTc5A4dUJl0ilg8oMrZyA0BGvc0/export?format=ods&id=1zYZ2107xOZwQ37AjLTc5A4dUJl0ilg8oMrZyA0BGvc0"
  # /fg FAQ
  # https://docs.google.com/document/d/1MRdRKbuM3KdO604kXTdSRTApO8Njlhu_5IVsNXsqpcY/edit
  "https://docs.google.com/document/export?format=odt&id=1MRdRKbuM3KdO604kXTdSRTApO8Njlhu_5IVsNXsqpcY&includes_info_params=true"
  # ACNE FAQ
  # https://docs.google.com/document/d/1qd6RWExT_EovutK0X7Oy134ONtQPHgulVIgewCz6Huc/edit
  "https://docs.google.com/document/export?format=odt&id=1qd6RWExT_EovutK0X7Oy134ONtQPHgulVIgewCz6Huc&includes_info_params=true"
  # Maddy Games
  # https://docs.google.com/spreadsheets/d/1csPBzPf5kIt5RdEi_BqKFRFyuWoCLku_RTa_2JuM9Ws/edit
  "https://docs.google.com/spreadsheets/d/1csPBzPf5kIt5RdEi_BqKFRFyuWoCLku_RTa_2JuM9Ws/export?format=ods&id=1csPBzPf5kIt5RdEi_BqKFRFyuWoCLku_RTa_2JuM9Ws"
)

cpx "${list[@]}"

# time tests
#\time --format "took %E" wget -N --content-disposition "https://docs.google.com/spreadsheets/d/12LoEfbaudLLQRNEhCCrsV4Js0p2lbNimOCbSnKUr5yc/export?format=ods&id=12LoEfbaudLLQRNEhCCrsV4Js0p2lbNimOCbSnKUr5yc"
#\time --format "took %E" cpx -O "https://docs.google.com/spreadsheets/d/12LoEfbaudLLQRNEhCCrsV4Js0p2lbNimOCbSnKUr5yc/export?format=ods&id=12LoEfbaudLLQRNEhCCrsV4Js0p2lbNimOCbSnKUr5yc"
# or -fSL -R -J -O
