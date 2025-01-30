using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Script_cubic : MonoBehaviour
{
    public GameObject prefub1;   

    MeshRenderer rend;

    public float minX; public float maxX;
    public float minZ; public float maxZ;

    public float nX; public float nY; public float nZ;
    void Start()
    {
        rend = gameObject.GetComponent<MeshRenderer>();
        minX = rend.bounds.min.x; maxX = rend.bounds.max.x;
        minZ = rend.bounds.min.z; maxZ = rend.bounds.max.z;

        nY = gameObject.transform.position.y + 5;
    }

    void Update()
    {
        nX = Random.Range(minX, maxX);
        nZ = Random.Range(minZ, maxZ);

        if (Input.GetKeyDown(KeyCode.Q))
        {
            GameObject cub = GameObject.CreatePrimitive(PrimitiveType.Cube);
            cub.transform.position = new Vector3(nX, nY, nZ);
            cub.AddComponent<Rigidbody>();
        }

        if (Input.GetKeyDown(KeyCode.Space))
        {
            Vector3 position = new Vector3(nX, nY, nZ);
            Instantiate(prefub1, position, Quaternion.identity);
        }

        if (Input.GetKey(KeyCode.W))
        {
            Quaternion rotZ = Quaternion.AngleAxis(-0.3f, new Vector3(0, 0, 1));
            transform.rotation *= rotZ;
        }
        if (Input.GetKey(KeyCode.S))
        {
            Quaternion rotZ = Quaternion.AngleAxis(0.3f, new Vector3(0, 0, 1));
            transform.rotation *= rotZ;
        }

    }
}
