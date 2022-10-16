#!/bin/python3

import requests
import json

index = 1

#while index <= 10:
#    url = "https://rickandmortyapi.com/api/character/{}".format(index)
#    request = requests.get(url)
#    json_request = request.json()
#    name = json_request['name']
#    status = json_request['status']
#    print('El personaje {} tiene status: {}'.format(name,status))
#    index +=1


#Request al primer episodio
#print("Por favor, selecciona el episodio del cual quiere consultar los personajes participantes: ")
#episodio = input()

#url = 'https://rickandmortyapi.com/api/episode/{}'.format(episodio) 
#r = requests.get(url)
#j = r.json()
#dict_keys(['id', 'name', 'air_date', 'episode', 'characters', 'url', 'created'])
#print(j['characters'][0])
def get_personajes(episodio):
    url = 'https://rickandmortyapi.com/api/episode/{}'.format(episodio) 
    headers = requests.utils.default_headers()

    headers.update(
        {
            'User-Agent': 'My User Agent 1.0',
        }
    )

  
    r = requests.get(url, headers=headers, timeout=0.10)
    j = r.json()
    print(r.raise_for_status())
    print('Personajes que aparecen en el capitulo {}:'.format(episodio))
    for url in j['characters']:
            try:
                headers = requests.utils.default_headers()

                headers.update(
                    {
                        'User-Agent': 'My User Agent 1.0',
                    }
                )
                personaje = requests.get(url, headers=headers, timeout=3)
                json_pj = personaje.json()
                print(json_pj['name'])
            except:
                print("El personaje no se pudo cargar")
            
episodio = 17
while episodio <= 20:
    get_personajes(episodio)
    episodio +=1