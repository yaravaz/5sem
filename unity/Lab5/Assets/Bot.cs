using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using UnityEngine;

public class Bot : MonoBehaviour
{
    float movespeed = 0.25f;	
    float rotspeedtank = 1.0f;	
    float rotspeedbash = 1.0f;	
    float speedcore = 3f;		
    public Transform bash;	    
    public Transform stvol;	    
    public GameObject core;	    
    bool canshoot = true;	    
    int life = 3;			    

    void Start()
    {

    }

    void Update()
    {

    }
    private void OnTriggerStay(Collider other)
    {
        if (other.name == "TriggTank")
        {
            Vector3 relativePos = other.transform.position - transform.position;
            Quaternion newrot = Quaternion.LookRotation(relativePos);

            bash.rotation = Quaternion.Slerp(bash.rotation, newrot, Time.deltaTime * rotspeedbash);

            RaycastHit hit;

            if(Physics.Raycast(bash.position, bash.TransformDirection(Vector3.forward), out hit))
            {
                if((hit.transform.name == "corpus") && canshoot) 	
                    StartCoroutine(botshoot());
            }

            float distance = Vector3.Distance(other.transform.position, transform.position);
            if(distance < 20)
            {
                transform.rotation = Quaternion.Slerp(transform.rotation, newrot, Time.deltaTime * rotspeedtank);
                transform.position = Vector3.Lerp(transform.position, other.transform.position, Time.deltaTime * movespeed);   
            }
        }
    }
    IEnumerator botshoot()
    {
        canshoot = false;
        Vector3 spawnPosition = stvol.position + stvol.forward * 6f;

        Instantiate(core, spawnPosition, stvol.transform.rotation);

        yield return new WaitForSeconds(2f);
        canshoot = true;
    }



    private void OnCollisionEnter(Collision col)
    {
        if (col.gameObject.name == "Missile(Clone)")
        {
            life--;
            if (life < 1) Destroy(gameObject);
        }

    }


}
