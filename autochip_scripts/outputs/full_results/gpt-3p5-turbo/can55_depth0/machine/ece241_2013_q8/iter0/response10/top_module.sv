module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // State declaration
    typedef enum logic [1:0] {
        S,
        S1,
        S10
    } state_t;
    
    // Registers
    reg [1:0] state, next_state;
    
    // Next state logic
    always_ff @(posedge clk or negedge aresetn) begin
        if (~aresetn) begin
            state <= S;
        end else begin
            state <= next_state;
        end
    end
    
    // Output logic
    always_comb begin
        case (state)
            S: begin
                z = 0;
            end
            S1: begin
                z = 0;
            end
            S10: begin
                z = x;
            end
        endcase
    end
    
    // Next state logic
    always_comb begin
        case ({x, state})
            2'b00: begin
                next_state = S;
            end
            2'b01: begin
                next_state = S1;
            end
            2'b10: begin
                next_state = S10;
            end
            2'b11: begin
                next_state = S1;
            end
        endcase
    end

endmodule
