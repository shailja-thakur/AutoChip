module top_module (
	input clk,
	input in,
	input areset,
	output out
);

    // Define states
    typedef enum logic [1:0] {
        B,
        A
    } STATES;
    
    // Define current state and next state
    reg [1:0] current_state, next_state;
    
    // Output
    assign out = (current_state == A) ? 1'b1 : 1'b0;
    
    // State transition and output logic
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            current_state <= B;
        end else begin
            current_state <= next_state;
            case (current_state)
                B: begin
                    if (in) begin
                        next_state <= B;
                    end else begin
                        next_state <= A;
                    end
                end
                A: begin
                    if (in) begin
                        next_state <= A;
                    end else begin
                        next_state <= B;
                    end
                end
            endcase
        end
    end
    
endmodule
