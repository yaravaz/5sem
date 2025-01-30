using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MoveCapsule : MonoBehaviour
{
    public float moveSpeed = 0.1f;
    public Texture texture1;
    public Texture texture2;
    public Texture texture3;

    public GameObject Cube1;
    void Start()
    {
        
    }

    void Update()
    {
        float moveHorizontal = Input.GetAxis("Horizontal");
        float moveVertical = Input.GetAxis("Vertical");

        Vector3 movement = new Vector3(moveHorizontal, 0f, moveVertical) * moveSpeed * Time.deltaTime;
        transform.Translate(movement);

        float mouseX = Input.GetAxis("Mouse X");
        Vector3 rotation = new Vector3(0f, mouseX, 0f) * moveSpeed;
        transform.Rotate(rotation);

        if (Input.GetKeyDown(KeyCode.R))
        {
            if (Cube1 != null)
            {
                print("Cube1");
                Cube1.GetComponent<Renderer>().material.mainTexture = texture3;
            }
        }
    }
    private void OnCollisionEnter(Collision col)
    {
        
        if (col.gameObject.name == "Cube1")
        {
            col.gameObject.GetComponent<Renderer>().material.mainTexture = texture1;
        }
        else if (col.gameObject.name == "Cube2")
        {
            col.gameObject.GetComponent<Renderer>().material.mainTexture = texture2;
        }
    }
}
