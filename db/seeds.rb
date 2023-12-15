require 'Faker'
Faker::Config.locale= 'fr'
require "open-uri"

# Créer 10 users
10.times do |i|
  i = i + 1
  User.create!(
    email: "test@user#{if i > 1 then i.to_s else '' end}.com",
    password: 'password',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
end

# Créer un admin
User.create!(
  email: 'test@admin.com',
  password: 'password'
)

# Créer 10 véritables associations
10.times do |i|
  i = i + 1
  case i
    when 1
      name = "CROIX ROUGE FRANCAISE (CRF)"
      description = "prévenir et alléger en toutes circonstances les souffrances humaines. Protéger la vie et la santé ainsi qu'à faire respecter la personnes humaine."
      city = "PARIS 14E"
      zip = "75694"
      address = "98 rue didot"
      rna = "W751004076"
      cover_photo = "https://seeklogo.com/images/C/croix-rouge-francaise-logo-EBF1EF9F37-seeklogo.com.png"
    when 2
      name = "SECOURS POPULAIRE"
      description = "soutenir l'esprit de la déclaration universelle des droits de l'Homme, au plan matériel, sanitaire, médical, moral et juridique les personnes et leurs familles victimes de l'arbitraire, de l'injustice sociale, des calamités naturelles, de la misère, de la faim, du sous-développement, des conflits armés ; ils rassemblent en leur sein des personnes de bonne volonté, enfants, jeunes, et adultes, de toutes conditions, quelles que soient leurs opinions politiques, philosophiques ou religieuses, en veillant à développer avec elles la solidarité et toutes les qualités humaines qui y sont liées"
      city = "Marseille"
      zip = "13014"
      address = "169 chemin de gibbes"
      rna = nil
      cover_photo = "https://upload.wikimedia.org/wikipedia/fr/thumb/8/80/Secours_populaire_logo.svg/1200px-Secours_populaire_logo.svg.png"
    when 3
      name = "ASSOCIATION COMMUNAUTE EMMAUS DU CLERMONTOIS FONDATION ABBE PIERRE"
      description = "Mettre en oeuvre les orientations d'emmaus dans l'esprit du manifeste universel actions solidarites"
      city = "AGNETZ"
      zip = "60600"
      address = "213 rue henri Ayrald"
      rna = "W602000223"
      cover_photo = "https://upload.wikimedia.org/wikipedia/fr/thumb/4/4d/Logo_EF_Couleur.svg/2560px-Logo_EF_Couleur.svg.png"
    when 4
      name = "ASSOCIATION FEMME FABULEUSE ET FORTE (FFF)"
      description = ""
      city = "CHELLES"
      zip = "77500"
      address = "14 FIZEAU"
      rna = "W771018268"
      cover_photo = nil
    when 5
      name = "COALLIA"
      description = "association de solidarité oeuvrant principalement dans le secteur de l'action sociale et médico-sociale ; intervient en particulier au profit des publics suivants : populations issues de l'immigration, personnes en demande d'asile ou ayant obtenu le statut de réfugié, personnes sans abri, personnes ayant des besoins spécifiques d'accompagnement social ou médical, telles que les personnes âgées dépendantes ou non, les personnes en situation de handicap et les jeunes travailleurs, et plus généralement, tous les publics en difficulté d'insertion sociale ou professionnelle"
      city = "PARIS"
      zip = "75012"
      address = "16-18 COUR SAINT ELOI"
      rna = "W751010758"
      cover_photo = "https://www.migdev.org/wp-content/uploads/2012/04/Logo-coallia.png"
    when 6
      name = "SOCIETE NATIONALE D'ENTRAIDE DE LA MEDAILLE MILITAIRE (SNEMM)"
      description = "Aide pécuniaire aux médaillés militaires et aux veuves et éducation des orphelins"
      city = "PARIS"
      zip = "75008"
      address = "36 RUE DE LA BIENFAISANCE"
      rna = "W751010031"
      cover_photo = "https://site.assoconnect.com/services/storage?id=1224539&type=picture&secret=2jpy2K93uWXGGn1rGE6okkSzkU43zTeClqyTKoKC&timestamp=1601383346"
    when 7
      name = "ASSOCIATION AURORE"
      description = "Réadaptation sociale et professionnelle des personnes que la maladie, l'isolement, les détresses morales et matérielles, un séjour en prison ou à l'hôpital ont privé d'une vie normale"
      city = "PARIS 15E"
      zip = "75015"
      address = "31 RUE FALGUIERE"
      rna = "W931006748"
      cover_photo = "https://upload.wikimedia.org/wikipedia/fr/f/fe/Association_Aurore_logo.png"
    when 8
      name = "SOCIETE NATIONALE DE SAUVETAGE EN MER"
      description = "Sauvetage de la vie humaine en mer"
      city = "PARIS"
      zip = "75009"
      address = "8 CITÉ D'ANTIN"
      rna = "W759000011"
      cover_photo = "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7d/Logo_officiel_de_la_SNSM_nouvelle_version_2022.png/800px-Logo_officiel_de_la_SNSM_nouvelle_version_2022.png"
    when 9
      name = "AFTRAL"
      description = "favoriser, par tous moyens, le développement de la formation professionnelle, notamment continue, dans les transports et ses activités auxiliaires, dans le tourisme ainsi que dans l'entreposage, la manutention, les activités logistiques, en cohérence avec les orientations générales définies par l'aft ; dispenser, ou de faire dispenser, toutes actions de formation et de conseils de toute nature et de tous niveaux, dans le cadre des dispositions de la sixième partie du code du travail relative à la formation professionnelle tout au long de la vie, au bénéfice de toute personne souhaitant se former ou se perfectionner aux métiers liés au transport et à ses activités auxiliaires, au tourisme, à l'entreposage, à la manutention et aux activité logistique ; de réaliser ou faire réaliser toutes études, d'éditer ou faire éditer tous ouvrages, publications, d'informer tout public sur les formations relatives aux métiers du transport et à ses activités auxiliaires, au tourisme, à l'entreposage, à la manutention et aux activités logistiques"
      city = "75017"
      zip = "PARIS"
      address = "46 AVENUE DE VILLIERS"
      rna = "W751040021"
      cover_photo = "https://www.merignachandball.fr/wp-content/uploads/2015/04/Logo-Aftral.png"
    when 10
      name = "UNION NATIONALE DU SPORT SCOLAIRE (UNSS)"
      description = "organiser et développer la pratique d'activités sportives, composantes de l'éducation physique et sportive, et l'apprentissage de la vie associative par les élèves qui ont adhéré aux associations sportives des établissements du second degré"
      city = "PARIS"
      zip = "75009"
      address = "13 RUE SAINT LAZARE"
      rna = "W751045794"
      cover_photo = "https://upload.wikimedia.org/wikipedia/commons/d/de/Logo_UNSS.png"
  end
  
  asso = Organisation.create!(
    email: "test@asso#{if i > 1 then i.to_s else '' end}.com",
    password: 'password',
    name: name,
    description: description,
    city: city,
    zip: zip,
    address: address,
    rna: rna,
  )

  # Attach cover photo
  if cover_photo
    img = URI.open(cover_photo)
    img_blob = ActiveStorage::Blob.create_and_upload!(
      io: img,
      filename: File.basename(URI.parse(cover_photo).path),
      content_type: 'image/png'
    )
    asso.cover_photo.attach(img_blob)
    asso.save!
  end
end

# Création de 10 events
10.times do |i|
  i = i + 1
  start_date = Date.today + rand(1..10)
  event = Event.create!(
    name: Faker::Book.title,
    description: Faker::Marketing.buzzwords,
    start_date: start_date,
    end_date: start_date + rand(1..10),
    organisation: Organisation.all.sample
  )

  img = URI.open("https://picsum.photos/400/200?random=#{i}")
  img_blob = ActiveStorage::Blob.create_and_upload!(
    io: img,
    filename: File.basename(URI.parse("https://picsum.photos/400/200?random=#{i}").path),
    content_type: 'image/jpg'
  )
  event.cover_photo.attach(img_blob)
  event.save!
end

# Associer des likes entre 0 et 3 à chaque user
User.all.each do |user|
  rand(0..3).times do
    Like.create!(
      user: user,
      organisation: Organisation.all.sample
    )
  end
end

# Faire participer les users à entre 0 et 3 events
User.all.each do |user|
  rand(0..3).times do
    Attendance.create!(
      user: user,
      event: Event.all.sample
    )
  end
end

# Créer 50 dons aléatoirement
50.times do |i|
  Donation.create!(
    amount: rand(1.0..50.0),
    user: User.all.sample,
    organisation: Organisation.all.sample,
    tip_amount: rand().round
  )
end

# Créer 5 mises en avant
5.times do |i|
  start_date = Date.today - rand(1..3)
  Promoted.create!(
    organisation: Organisation.all.sample,
    start_date: start_date,
    end_date: start_date + rand(3..10),
    price: rand(7.0..19.0),
  )
end

# Créer des questions et des réponses pour chaque association (entre 0 et 3)
Organisation.all.each do |organisation|
  rand(0..3).times do
    Faq.create!(
      question: Faker::Lorem.sentence,
      answer: Faker::Lorem.paragraph,
      organisation: organisation,
      user: User.all.sample
    )
  end
end