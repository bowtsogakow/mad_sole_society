
class Database {

List shoes = [
  {
    "id": 1,
    "Name": "Nike Air Force 1 '07 LV8",
    "Brand": "Nike",
    "Price": 6195,
    "Women": 0,
    "Men": 1,
    "Kids": 0,
    "Running": 0,
    "Bastketball": 0,
    "Aesthethic": 1,
    "Skateboarding": 0,
    "short_description": "Wintertime warmth meets AF-1 style. The radiance lives on with the b-ball original. Crossing hardwood comfort with off-court flair, it puts a soft, cold-weather spin on what you know best: era-echoing '80s construction, bold details and nothing-but-n",
    "filename": "Nike Air Force 1 _07 LV8.png"
  },

  {
    "id": 2,
    "Name": "Nike Air Max 97",
    "Brand": "Nike",
    "Price": 4295,
    "Women": 0,
    "Men": 1,
    "Kids": 0,
    "Running": 0,
    "Bastketball": 0,
    "Aesthethic": 1,
    "Skateboarding": 0,
    "short_description": "Featuring the original ripple design inspired by Japanese bullet trains, the Nike Air Max 97 lets you push your style full-speed ahead.Taking the revolutionary full-length Nike Air unit that shook up the running world and adding fresh colours and cri",
    "filename": "Nike Air Max 97.png"
  },

  {
    "id": 3,
    "Name": "Nike Waffle Debut Vintage",
    "Brand": "Nike",
    "Price": 4295,
    "Women": 1,
    "Men": 0,
    "Kids": 0,
    "Running": 1,
    "Bastketball": 0,
    "Aesthethic": 1,
    "Skateboarding": 0,
    "short_description": "We've got a secret: these retro kicks are brand spanking new. Done in fluffy suede and airy textile, they deliver era-echoing, '70s style with modern comfort. An updated wedge midsole gives the cushioning a serious boost, while maintaining the iconic",
    "filename": "Nike Waffle Debut SE.png"
  },

  {
    "id": 4,
    "Name": "Questar shoes",
    "Brand": "Adidas",
    "Price": 4500,
    "Women": 0,
    "Men": 1,
    "Kids": 0,
    "Running": 1,
    "Bastketball": 0,
    "Aesthethic": 0,
    "Skateboarding": 0,
    "short_description": "The longer the run, the more time you get to spend out in the fresh air. Build distance into your running routine in the cushioned comfort of these adidas running shoes. A full-length Bounce midsole provides soft landings on every stride. A lightweig",
    "filename": "QUESTAR SHOES.png"
  },

  {
    "id": 5,
    "Name": "Forum Mid Shoes",
    "Brand": "Adidas",
    "Price": 5500,
    "Women": 1,
    "Men": 0,
    "Kids": 0,
    "Running": 0,
    "Bastketball": 1,
    "Aesthethic": 1,
    "Skateboarding": 0,
    "short_description": "Whether you're out on the town or chilling with friends, these adidas shoes add a touch of comfort and vintage cool to your look. The OG '80s elements get a luxe update with a suede upper, nubuck stripes and a quilted collar. A terry lining creates a",
    "filename": "FORUM MID SHOES.png"
  },

  {
    "id": 6,
    "Name": "Crazy 8 Shoes",
    "Brand": "Adidas",
    "Price": 8500,
    "Women": 0,
    "Men": 1,
    "Kids": 0,
    "Running": 0,
    "Bastketball": 1,
    "Aesthethic": 1,
    "Skateboarding": 0,
    "short_description": "Bring a fearless spirit to each step with the Crazy 8 shoes. This pair is a revival of a '90s design that became one of adidas' most iconic and beloved looks. A cushy EVA midsole, complete with Torsion System, nods to its basketball roots and a premi",
    "filename": "CRAZY 8 SHOES.png"
  },

  {
    "id": 7,
    "Name": "Nike Court Legacy Lift",
    "Brand": "Nike",
    "Price": 4495,
    "Women": 1,
    "Men": 0,
    "Kids": 0,
    "Running": 0,
    "Bastketball": 0,
    "Aesthethic": 1,
    "Skateboarding": 0,
    "short_description": "Elevate your style with the Nike Court Legacy Lift. Its platform midsole delivers a bold statement on top of the classic, easy-to-wear design. And don't worry, we've kept the fit you love.",
    "filename": "Nike Court Legacy Lift.png"
  },

  {
    "id": 8,
    "Name": "Nike Blazer Low '77",
    "Brand": "Nike",
    "Price": 2495,
    "Women": 0,
    "Men": 0,
    "Kids": 1,
    "Running": 0,
    "Bastketball": 0,
    "Aesthethic": 1,
    "Skateboarding": 0,
    "short_description": "The Nike Blazer Low '77 has transcended the basketball court to streetwear and is ready to land on your kid's feet. Tuck their toes into this icon for an old-school look that keeps little feet comfy on all their adventures.",
    "filename": "Nike Blazer Low Platform.png"
  },

  {
    "id": 9,
    "Name": "Nike Full Force Low",
    "Brand": "Nike",
    "Price": 4995,
    "Women": 0,
    "Men": 1,
    "Kids": 0,
    "Running": 0,
    "Bastketball": 0,
    "Aesthethic": 0,
    "Skateboarding": 0,
    "short_description": "A new shoe with old-school appeal—your retro dreams just came true. This pared-back design references the classic AF-1, then leans into '80s style with throwback stitching and varsity-inspired colours. Not everything has to be a throwback, though—mod",
    "filename": "Nike Full Force Low.png"
  },

  {
    "id": 10,
    "Name": "Rowan 2 Shoe",
    "Brand": "Vans",
    "Price": 6300,
    "Women": 1,
    "Men": 1,
    "Kids": 0,
    "Running": 0,
    "Bastketball": 0,
    "Aesthethic": 0,
    "Skateboarding": 1,
    "short_description": "Rowan Zorilla loose, free-flowing style and uncanny ability to adapt to just about any spot has contributed to reshaping the way future generations think about skateboarding. With that in mind, Vans worked with Rowan to create the Rowan 2, an evolu",
    "filename": "Rowan 2 Shoe.png"
  },

  {
    "id": 11,
    "Name": "Chukka Low Sidestripe Shoe",
    "Brand": "Vans",
    "Price": 4500,
    "Women": 1,
    "Men": 1,
    "Kids": 0,
    "Running": 0,
    "Bastketball": 0,
    "Aesthethic": 0,
    "Skateboarding": 1,
    "short_description": "The Chukka Low Sidestripe, a vulcanized shoe designed by the Vans skate team and inspired by classics like the Authentic and the Chukka Boot, brings a new heritage aesthetic to this old school skate shoe. Featuring our iconic Sidestripe, this low top",
    "filename": "Chukka Low Sidestripe Shoe.png"
  },

  {
    "id": 12,
    "Name": "Zahba Mid Shoe",
    "Brand": "Vans",
    "Price": 6300,
    "Women": 1,
    "Men": 1,
    "Kids": 0,
    "Running": 0,
    "Bastketball": 0,
    "Aesthethic": 0,
    "Skateboarding": 1,
    "short_description": "When impact protection and boardfeel come together, skateboarders have the best opportunity to make an impact. That’s why the Zahba Mid features Vans’ best impact cushioning outsole design yet: the ImpactWaffle. Its unique three-part design—two layer",
    "filename": "Zahba Mid Shoe.png"
  },

  {
    "id": 13,
    "Name": "Reebok Nano X3",
    "Brand": "Reebok",
    "Price": 6396,
    "Women": 1,
    "Men": 0,
    "Kids": 0,
    "Running": 1,
    "Bastketball": 0,
    "Aesthethic": 0,
    "Skateboarding": 0,
    "short_description": "Believe it or not, there's a training shoe you can actually run in. Meet the women's Reebok Nano X3 training shoes with the all new Lift and Run Chassis system. A dome-shaped heel piece compresses under load when lifting to create a stable platform, ",
    "filename": "Reebok Nano X3 Women_s Training Shoes.png"
  },

  {
    "id": 14,
    "Name": "Reebok C 85 Vegan",
    "Brand": "Reebok",
    "Price": 2577,
    "Women": 1,
    "Men": 0,
    "Kids": 1,
    "Running": 0,
    "Bastketball": 0,
    "Aesthethic": 1,
    "Skateboarding": 0,
    "short_description": "Pair your principles with your fashion. These Club C 85 shoes are not only fresh, they're completely vegan. Two-toned webbing gives you a pop of color. Style win.",
    "filename": "Reebok Club C 85 Vegan.png"
  },

  {
    "id": 15,
    "Name": "Fresh Foam Arishi v4 Bungee Lace with Top Str",
    "Brand": "New Balance",
    "Price": 2600,
    "Women": 0,
    "Men": 0,
    "Kids": 1,
    "Running": 1,
    "Bastketball": 0,
    "Aesthethic": 0,
    "Skateboarding": 0,
    "short_description": "The New Balance Fresh Foam Arishi v4 Bungee Lace is a versatile shoe for growing feet. Featuring a soft Fresh Foam cushioned midsole and rubber outsole pods, this sporty kids’ running shoe blends next-level style with all-day comfort. The synthetic a",
    "filename": "Fresh Foam Arishi v4 Bungee Lace with Top Strap.png"
  },

  {
    "id": 16,
    "Name": "Rave Run v2 Bungee Lace with Top Strap",
    "Brand": "New Balance",
    "Price": 2600,
    "Women": 0,
    "Men": 0,
    "Kids": 1,
    "Running": 1,
    "Bastketball": 0,
    "Aesthethic": 0,
    "Skateboarding": 0,
    "short_description": "Our bold Rave Run V2 kids’ running shoe delivers plush comfort with a cool, youthful vibe. The mesh upper is lightweight and breathable, featuring a no-sew tip for durability and no-sew saddle for midfoot support. Underfoot, an IMEVA midsole offers c",
    "filename": "Rave Run v2 Bungee Lace with Top Strap.png"
  },

  {
    "id": 17,
    "Name": "550 Bungee Lace with Top Strap",
    "Brand": "New Balance",
    "Price": 4800,
    "Women": 0,
    "Men": 0,
    "Kids": 0,
    "Running": 0,
    "Bastketball": 1,
    "Aesthethic": 0,
    "Skateboarding": 0,
    "short_description": "Dress up growing feet in the classic 550 Bungee Lace with Top Strap for kids. The original 550 debuted in 1989 and made its mark on basketball courts from coast to coast. After its initial run, the 550 was filed away in the archives, before being rei",
    "filename": "550 Bungee Lace with Top Strap.png"
  },

  {
    "id": 18,
    "Name": "Reebok Rewind Run Ripple",
    "Brand": "Reebok",
    "Price": 3865,
    "Women": 0,
    "Men": 1,
    "Kids": 0,
    "Running": 1,
    "Bastketball": 0,
    "Aesthethic": 0,
    "Skateboarding": 0,
    "short_description": "A MODERN SNEAKER WITH VINTAGE APPEAL, INSPIRED BY 80S KICKS, THESE SNEAKERS ARE DESIGNED IN A RETRO-INFLECTED PALETTE OF CREAM AND BROWN AND SET ON A GUM SOLE. A MOLDED SOCKLINER AND EVA FOAM MIDSOLE LOAD THEM WITH NEXT-LEVEL COMFORT, WHILE AN ORANGE",
    "filename": "Reebok Rewind Run Ripple.png"
  },

  {
    "id": 19,
    "Name": "Reebok Zig Encore",
    "Brand": "Reebok",
    "Price": 2797,
    "Women": 0,
    "Men": 1,
    "Kids": 0,
    "Running": 0,
    "Bastketball": 1,
    "Aesthethic": 0,
    "Skateboarding": 0,
    "short_description": "Running heritage meets basketball tradition in these Reebok shoes. These kicks have a zigzag pattern on a soft, moulded midsole that cushions every step while making a statement with your outfit.",
    "filename": "Reebok Zig Encore Basketball Shoes.png"
  },

  {
    "id": 20,
    "Name": "Star Player 76 Shoes",
    "Brand": "Converse",
    "Price": 4790,
    "Women": 0,
    "Men": 1,
    "Kids": 0,
    "Running": 0,
    "Bastketball": 0,
    "Aesthethic": 0,
    "Skateboarding": 1,
    "short_description": "STYLE STEP Show off your unique flair with these classic low-tops. Bold colors mingle with suede features and a leather Star Chevron for a look best served with a sporty edge.",
    "filename": "Star Player 76 Premium Canvas.png"
  },

  {
    "id": 21,
    "Name": "Star Player 76 Sport Remastered",
    "Brand": "Converse",
    "Price": 4490,
    "Women": 0,
    "Men": 1,
    "Kids": 0,
    "Running": 0,
    "Bastketball": 0,
    "Aesthethic": 0,
    "Skateboarding": 1,
    "short_description": "CONICALLY YOU Converse knows what it takes to reach icon status. Timeless style, relentless innovation, andâ€”you. That's why the Star Player 76 was made for you and your lifestyle. The dialed-in, court shoe-inspired design is entirely Converse, but ",
    "filename": "Star Player 76 Sport Remastered.png"
  },

  {
    "id": 22,
    "Name": "Chuck 70 OX Shoes - Black",
    "Brand": "Converse",
    "Price": 4190,
    "Women": 0,
    "Men": 1,
    "Kids": 0,
    "Running": 0,
    "Bastketball": 0,
    "Aesthethic": 1,
    "Skateboarding": 1,
    "short_description": "By 1970, the Chuck Taylor All Star evolved into one of the best basketball sneakers, ever. The Chuck 70 celebrates that heritage by bringing together archival-inspired details with modern comfort updates. OthoLite insole cushioning and winged tongue ",
    "filename": "Chuck 70 OX Shoes.png"
  },

  {
    "id": 23,
    "Name": "Sk8-Hi Shoe",
    "Brand": "Vans",
    "Price": 4181,
    "Women": 1,
    "Men": 1,
    "Kids": 1,
    "Running": 0,
    "Bastketball": 0,
    "Aesthethic": 0,
    "Skateboarding": 1,
    "short_description": "High-tops changed the sneaker game, and the Vans Style #38 was at the forefront of the revolution. Now beloved as the Sk8-Hi sneaker, this legendary high-top shoe blazed trails from the beginning. The sturdy suede and canvas uppers allow for maximum ",
    "filename": "Sk8-Hi Shoe.png"
  },

  {
    "id": 24,
    "Name": "Authentic Shoe",
    "Brand": "Vans",
    "Price": 3066,
    "Women": 1,
    "Men": 1,
    "Kids": 0,
    "Running": 0,
    "Bastketball": 0,
    "Aesthethic": 0,
    "Skateboarding": 1,
    "short_description": "The Authentic is the original Vans silhouette. First introduced in 1966 and driven forward by creative culture ever since, this time-honored shoe keeps the old school vibe alive with sturdy canvas uppers in seasonal colorways. With its classic low-to",
    "filename": "Authentic Shoe.png"
  },

  {
    "id": 25,
    "Name": "Chuck 70 ",
    "Brand": "Converse",
    "Price": 4390,
    "Women": 1,
    "Men": 1,
    "Kids": 0,
    "Running": 0,
    "Bastketball": 1,
    "Aesthethic": 1,
    "Skateboarding": 1,
    "short_description": "A Converse icon from the 1970’s remastered for today with superior craftsmanship and premium materials. The best ever. ",
    "filename": "Chuck 70.png"
  },

  {
    "id": 26,
    "Name": "Chuck 70 AT-CX Platform",
    "Brand": "Converse",
    "Price": 5790,
    "Women": 1,
    "Men": 1,
    "Kids": 0,
    "Running": 0,
    "Bastketball": 0,
    "Aesthethic": 1,
    "Skateboarding": 0,
    "short_description": "The Chuck 70 AT-CX takes the best-ever design you know and love to new heights, with new purpose. Made for outdoor runners, the Chuck 70 AT-CX merges performance and comfort features to help you cover more ground than ever. A higher, platform midsole",
    "filename": "Chuck 70 AT-CX Platform.png"
  },

  {
    "id": 27,
    "Name": "SAMBA OG SHOES",
    "Brand": "Adidas",
    "Price": 6800,
    "Women": 1,
    "Men": 1,
    "Kids": 0,
    "Running": 0,
    "Bastketball": 1,
    "Aesthethic": 1,
    "Skateboarding": 0,
    "short_description": "Born on the pitch, the Samba is a timeless icon of street style. This silhouette stays true to its legacy with a tasteful, low-profile, soft leather upper, suede overlays and gum sole, making it a staple in everyone's closet - on and off the pitch.",
    "filename": "Samba OG.png"
  },

  {
    "id": 28,
    "Name": "CENTENNIAL 85 LOW SHOES",
    "Brand": "Adidas",
    "Price": 5300,
    "Women": 0,
    "Men": 1,
    "Kids": 0,
    "Running": 0,
    "Bastketball": 0,
    "Aesthethic": 0,
    "Skateboarding": 0,
    "short_description": "Celebrating archival hardwood DNA, the adidas Centennial 85 Low shoes are an homage to basketball icons. Crafted from a rich suede and nubuck upper, quilted detailing on the heel collar is the perfect contrast. With a perforated toe box, classic 3 st",
    "filename": "CENTENNIAL 85 LOW.png"
  },

  {
    "id": 29,
    "Name": "NMD_R1 SHOES",
    "Brand": "Adidas",
    "Price": 8000,
    "Women": 0,
    "Men": 1,
    "Kids": 1,
    "Running": 1,
    "Bastketball": 0,
    "Aesthethic": 0,
    "Skateboarding": 0,
    "short_description": "The snug, sock-like fit starts with a stretchy knit upper made with high-performance yarn that flexes with your feet. BOOST cushioning returns energy based on your stride, and a soft lining lets you skip socks if you want.",
    "filename": "NMD_R1 SHOES.png"
  },

  {
    "id": 30,
    "Name": "2002R 'Eclipse'",
    "Brand": "New Balance",
    "Price": 10495,
    "Women": 0,
    "Men": 1,
    "Kids": 0,
    "Running": 1,
    "Bastketball": 1,
    "Aesthethic": 0,
    "Skateboarding": 0,
    "short_description": "Taking inspiration from the well-received MR2002, the 2002R footwear presents a stylish nod to the running fashion of the 2000s. These men's sneakers feature robust leather uppers for enduring durability. The incorporation of impact-absorbing midsole",
    "filename": "2002R _Eclipse_.png"
  },

  {
    "id": 31,
    "Name": "480 'Brighton Grey'",
    "Brand": "New Balance",
    "Price": 5495,
    "Women": 0,
    "Men": 1,
    "Kids": 0,
    "Running": 0,
    "Bastketball": 0,
    "Aesthethic": 0,
    "Skateboarding": 0,
    "short_description": "Inspired by the classic basketball shoe model, BB680, the 480 lifestyle sneaker is simple, clean and classic.",
    "filename": "480.png"
  },

  {
    "id": 32,
    "Name": "YEEZY BOOST 350 V2",
    "Brand": "Adidas",
    "Price": 15000,
    "Women": 0,
    "Men": 1,
    "Kids": 0,
    "Running": 1,
    "Bastketball": 1,
    "Aesthethic": 0,
    "Skateboarding": 0,
    "short_description": "With a triple black Primeknit upper, the adidas Yeezy 350 V2 Onyx takes it back to the basics, using its muted palette to emphasize the intricacies of its construction. A sheer mesh side stripe and canvas heel loop offer a subtle contrast in texture.",
    "filename": "YEEZY BOOST 350 V2 .png"
  },

  {
    "id": 33,
    "Name": "Reebok Pump TZ",
    "Brand": "Reebok",
    "Price": 8995,
    "Women": 1,
    "Men": 1,
    "Kids": 0,
    "Running": 0,
    "Bastketball": 0,
    "Aesthethic": 0,
    "Skateboarding": 0,
    "short_description": "The Pump TZ launched in the early '90s, and it came back down with thunderous grace after every dunk and eye-catching finish at the rim. These men's Reebok shoes are back in their OG solar yellow colorway for a nostalgic look symbolic of a special er",
    "filename": "Reebok Pump TZ.png"
  },

  {
    "id": 34,
    "Name": "Reebok Club C Revenge Vintage",
    "Brand": "Reebok",
    "Price": 5295,
    "Women": 1,
    "Men": 0,
    "Kids": 0,
    "Running": 0,
    "Bastketball": 0,
    "Aesthethic": 1,
    "Skateboarding": 0,
    "short_description": "Archive-inspired shoes made of vintage-style leather Blast from the past. These tennis-inspired shoes are made of vintage-style leather for an old-school look and feel. A contrast heel tab and side stripes add even more retro flair.",
    "filename": "Reebok Club C Revenge Vintage.png"
  },

  {
    "id": 35,
    "Name": "Reebok Nano X3 Women's Training Shoes",
    "Brand": "Reebok",
    "Price": 7995,
    "Women": 0,
    "Men": 0,
    "Kids": 0,
    "Running": 1,
    "Bastketball": 0,
    "Aesthethic": 0,
    "Skateboarding": 0,
    "short_description": "Believe it or not, there's a training shoe you can actually run in. Meet the women's Reebok Nano X3 training shoes with the all new Lift and Run Chassis system. A dome-shaped heel piece compresses under load when lifting to create a stable platform, ",
    "filename": "Reebok Nano X3 Women_s Training Shoes.png"
  },

  {
    "id": 36,
    "Name": "UltraRange Rapidweld",
    "Brand": "Vans",
    "Price": 5017,
    "Women": 1,
    "Men": 1,
    "Kids": 1,
    "Running": 1,
    "Bastketball": 0,
    "Aesthethic": 0,
    "Skateboarding": 0,
    "short_description": "The UltraRange was the solution to our top athletes’ need for a versatile shoe that provided comfort for long journeys around the world. Combining its standout UltraCush midsole compound with advanced stitchless Rapidweld upper panel welding for even",
    "filename": "UltraRange Rapidweld.png"
  },

  {
    "id": 37,
    "Name": "Checkerboard Colfax Boot MTE-1 Shoe",
    "Brand": "Vans",
    "Price": 7526,
    "Women": 0,
    "Men": 0,
    "Kids": 0,
    "Running": 0,
    "Bastketball": 0,
    "Aesthethic": 1,
    "Skateboarding": 0,
    "short_description": "The original Colfax Boot has a utility design that already lends itself to MTE’s promise of Protection from the Elements. Built with rubber overlays, an MTE-approved lugged outsole, and easy on\/off pull tabs, this new MTE iteration is further support",
    "filename": "Checkerboard Colfax Boot MTE-1 Shoe.png"
  },

  {
    "id": 38,
    "Name": "B25 Runner Sneaker",
    "Brand": "Dior",
    "Price": 49060,
    "Women": 0,
    "Men": 1,
    "Kids": 0,
    "Running": 1,
    "Bastketball": 0,
    "Aesthethic": 0,
    "Skateboarding": 0,
    "short_description": "The B25 Runner sneaker pairs a sporty silhouette with House codes of elegance. Crafted in black smooth calfskin, the design is enhanced by iconic tonal Dior Oblique jacquard. Featuring a black sculpted rubber sole, the B25 Runner sneaker will complet",
    "filename": "B25 RUNNER SNEAKER.png"
  },

  {
    "id": 39,
    "Name": "B27 Low-Top Sneaker",
    "Brand": "Dior",
    "Price": 64113,
    "Women": 0,
    "Men": 1,
    "Kids": 0,
    "Running": 0,
    "Bastketball": 0,
    "Aesthethic": 1,
    "Skateboarding": 0,
    "short_description": "The B27 low-top sneaker is already a House essential. Crafted in blue, cream and Dior gray smooth calfskin, the style is adorned with beige and black Dior Oblique jacquard inserts on the sides. The sneaker is enhanced with 'CD Icon' eyelets as well a",
    "filename": "B27 LOW-TOP SNEAKER.png"
  },

  {
    "id": 40,
    "Name": "B33 Sneaker",
    "Brand": "Dior",
    "Price": 75263,
    "Women": 0,
    "Men": 1,
    "Kids": 0,
    "Running": 0,
    "Bastketball": 0,
    "Aesthethic": 1,
    "Skateboarding": 0,
    "short_description": "The B33 sneaker is a new take on the timeless tennis shoe with a play on volume in a modern silhouette. Crafted in khaki and cream Dior Oblique jacquard with khaki suede inserts, it is distinguished by a padded tongue featuring an embossed Dior signa",
    "filename": "B23 LOW-TOP SNEAKER.png"
  },

  {
    "id": 41,
    "Name": "B57 Mid-Top Sneaker",
    "Brand": "Dior",
    "Price": 69688,
    "Women": 0,
    "Men": 1,
    "Kids": 0,
    "Running": 0,
    "Bastketball": 0,
    "Aesthethic": 1,
    "Skateboarding": 0,
    "short_description": "New for Spring 2024, the B57 mid-top sneaker reframes the basketball shoe and is already a House essential. Crafted in black and white smooth calfskin, the style is adorned with a beige and black Dior Oblique jacquard signature on the side. The sneak",
    "filename": "B57 MID-TOP SNEAKER.png"
  },

  {
    "id": 42,
    "Name": "Dior Buffalo Derby",
    "Brand": "Dior",
    "Price": 7276,
    "Women": 0,
    "Men": 1,
    "Kids": 0,
    "Running": 0,
    "Bastketball": 0,
    "Aesthethic": 0,
    "Skateboarding": 0,
    "short_description": "New for Spring 2024, the Dior Buffalo Derby shoe combines iconoclastic elements with the House's couture aesthetic. The black smooth calfskin upper is enhanced by side inserts that feature a tonal debossed Dior Oblique motif, while the chunky rubber ",
    "filename": "DIOR BUFFALO DERBY SHOE.png"
  },

  {
    "id": 43,
    "Name": "B23 Low Top Logo Oblique",
    "Brand": "Dior",
    "Price": 35000,
    "Women": 0,
    "Men": 1,
    "Kids": 0,
    "Running": 0,
    "Bastketball": 0,
    "Aesthethic": 1,
    "Skateboarding": 0,
    "short_description": "The B23 low-top sneaker is set apart by its white and black Dior Oblique motif and transparent paneling. Essential details, such as eyelets and a lace-up front, a white and beige rubber sole, a rounded and reinforced toe as well as a back tab recall ",
    "filename": "B23 LOW-TOP SNEAKER.png"
  }
];

  // Return a whole JSON object of shoe; return a whole shoe
  Map<String, dynamic>? getProduct(id){
    for (var i in shoes){
      if(i["id"] == id){
        return i; 
      }
    }
    return null; 
  }

  // Search product through Name, return product ID
  int ? searchName(String name){
    for (var i in shoes){
      if(i["Name"] == name){
        return i["id"]; 
      }
    }
    return null; 
  }

  List ? searchWomen(){
    List id = []; 
    for (var i in shoes){
      if(i["Women"] == 1){
        id.add(i["id"]);
      }
    }
    return id; 
  }

  List ? searchMen(){
    List id = [];
    for (var i in shoes){
      if(i["Men"] == 1){
        id.add(i["id"]);
      }
    }
    return id; 
  }

  List ? searchKids(){
    List id = [];
    for (var i in shoes){
      if(i["Kids"] == 1){
        id.add(i["id"]);
      }
    }
    return id; 
  }

  List ? searchRunning(){
    List id = [];
    for (var i in shoes){
      if(i["Running"] == 1){
        id.add(i["id"]);
      }
    }
    return id; 
  }

  List ? searchBasketball(){
    List id = [];
    for (var i in shoes){
      if(i["Bastketball"] == 1){
        id.add(i["id"]);
      }
    }
    return id; 
  }

  List ? searchAesthethic(){
    List id = [];
    for (var i in shoes){
      if(i["Aesthethic"] == 1){
        id.add(i["id"]); 
      }
    }
    return id; 
  }

  List ? searchSkateboarding(){
    List id = [];
    for (var i in shoes){
      if(i["Skateboarding"] == 1){
        id.add(i["id"]); 
      }
    }
    return id; 
  }

  List ? searchBrand(String Brand){
    List id = [];
    for (var i in shoes){
      if(i["Brand"] == Brand){
        id.add(i["id"]); 
      }
    }
    return id; 
  }

  
}



