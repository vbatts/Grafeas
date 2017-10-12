/*
 * Grafeas API
 *
 * An API to insert and retrieve annotations on cloud artifacts.
 *
 * OpenAPI spec version: 0.1
 *
 * Generated by: https://github.com/swagger-api/swagger-codegen.git
 */

package api

// Response including listed notes.
type ListNotesResponse struct {

	// The occurrences requested
	Notes []Note `json:"notes,omitempty"`

	// The next pagination token in the List response. It should be used as page_token for the following request. An empty value means no more result.
	NextPageToken string `json:"nextPageToken,omitempty"`
}
