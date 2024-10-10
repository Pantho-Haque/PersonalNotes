#include <bits/stdc++.h>
using namespace std;

int main()
{
    /************************/
    // pair - maintain a relation among 2 set of data
    /************************/

    pair<int, string> p;
    p = make_pair(2, "abd");
    p = {2, "abc"};
    cout << p.first << " " << p.second << endl;

    /************************/
    // vector - continous blocks of memory, array of dynamic size,
    /************************/

    vector<int> v;
    vector<int> v5(5);             // vector of size 5 with value of 0
    vector<int> v10(10, 3);        // vector of size 5 with value fill of 3
    v.push_back(2);                // adds 2 at last // O(1)
    v.pop_back();                  // remove from last // O(1)
    int size_of_vector = v.size(); // O(1)
    vector<int> v2 = v;            // copy // O(n)
    // void printVec(vector<int> &v){
    //      sending reference to use a vector. passing copy is so expensive operation
    // }
    vector<pair<int, int>> vector_of_pair = {{1, 2}, {1, 2}, {1, 2}};
    cout << vector_of_pair[0].first << " " << vector_of_pair[0].second << endl;

    vector<int> array_of_vector[10];
    vector<vector<int>> vector_of_vector;
    vector_of_vector.push_back(vector<int>()); // inserting an empty vector

    /************************/
    // Iterator
    /************************/

    vector<int>::iterator it;
    // it ++ -> next iterator
    // it +1 -> next location
    for (it = v.begin(); it != v.end(); it++)
    {
        cout << *it << endl;
    }
    vector<pair<int, int>>::iterator it_of_vp;
    for (it_of_vp = vector_of_pair.begin();
         it_of_vp != vector_of_pair.end();
         it_of_vp++)
    {

        cout << (*it_of_vp).first << " " << (*it_of_vp).second << endl;
        cout << it_of_vp->first << " " << it_of_vp->second << endl;
    }
    // c++11
    // auto keyword and range based loops
    for (auto &value : v)
    {
        cout << value << endl;
    }

    /************************/
    // map-> internal implementation -> red black trees
    // every element is a pair, not continous addressing so it+1 is not allowed,
    // stores in increasing or laxiographical order of unique keys
    /************************/
    map<int, string> m;
    m[1] = "abc"; // m[key]=value // O(logn)
    m[1];         // inserts empty string(0 if data type was integer) // O(logn)
    m.insert({1, "abc"});
    m.size();            // number of pair
    auto itera = m.find(2); // returns an iterator of pair with key 2. returns m.end() if no item withe key 2 is found. //O(logn)
    m.erase(2);          // erase the element with key 2  //O(logn)
    m.erase(itera); // erase the element iterator is pointing. if(it==m.end()) -> segmentation fault arises  //O(logn)
    m.clear(); // clear the map
    for (auto &e : m)
    {
        // loop of complexity O(nlogn)-> n= items, logn = accessing element
        cout << e.first << " " << e.second << endl;
    }
    /************************/
    // unordered map-> internal implementation -> hash table
    // no order maintines while store
    // time complexity of insertion, accessing elements, .find , .erase is O(1) -> saves time
    // no complex datatype is allowd i.e pair<int,int>. cz their hash function is not internally defined. they can be used as keys in map cz they can be directly compared
    /************************/
    unordered_map<int, string> um;

    // multimap allows duplicate keys
    multimap<int , vector<string>> mmap;


    /************************/
    // sets -> set of unique values
    // internal implementation -> red black trees
    // stored in sorted order
    /************************/
    set<string> s;
    s.insert("abc");
    auto iteS = s.find("abc"); // check for it==s.end() to avoid segmentation fault //O(log n)
    s.erase("abc");
    s.erase(iteS);
    for( auto &i:s){
         cout << i << endl;
    }

    /************************/
    // unordered sets -> no order maintains -> use to check any element is present or not.
    // internal implementation -> hash table
    // O(1) complexity
    // no comlex data structures are allowed.
    /************************/
    unordered_set<string> us;

    /************************/
    // multiset - allow to insert multiple values in order
    // internal implementation -> red black trees
    // o(log n) complexity
    /************************/
    multiset<string> ms;
    auto iterMS=ms.find("anf"); // returns the iterator of first element found
    ms.erase(iterMS);   // removes the element iterator is pointing
    ms.erase("abc");    // removes all the element present in set for "abc" 

    /************************
    // stack-> LIFO
                        |   C   |
                        |   B   |
                        |___A___|
    ***********************/  
    stack<int>st;              
    st.push(1);                 
    st.top(); 
    st.pop();   // remove top element
    st.empty()  // returns boolean if stack is empty or not

     /************************
    // queue-> FIFO
                    _________________
                    A | B | C
                    _________________
    ***********************/  
    queue<int>q;              
    q.push(1); // add element to back                
    q.front(); 
    q.pop();   // remove front element

}