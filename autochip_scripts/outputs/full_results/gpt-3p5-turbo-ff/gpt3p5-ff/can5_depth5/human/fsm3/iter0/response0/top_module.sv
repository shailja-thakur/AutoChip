module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // Define states
    typedef enum logic [1:0] {A, B, C, D} state_t;
    
    // Define state register
    reg [1:0] current_state;
    reg [1:0] next_state;
    
    // Define output register
    reg [0:0] current_output;
    
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            current_state <= A;
            current_output <= 0;
        end else begin
            current_state <= next_state;
            current_output <= current_output;
        end
    end
    
    always @* begin
        case (current_state)
            A: begin
                if (in == 0)
                    next_state = A;
                else
                    next_state = B;
                current_output = 0;
            end
            B: begin
                if (in == 0)
                    next_state = C;
                else
                    next_state = B;
                current_output = 0;
            end
            C: begin
                if (in == 0)
                    next_state = A;
                else
                    next_state = D;
                current_output = 0;
            end
            D: begin
                if (in == 0)
                    next_state = C;
                else
                    next_state = B;
                current_output = 1;
            end
            default: begin
                next_state = A;
                current_output = 0;
            end
        endcase
    end
    
    assign out = current_output;
    
endmodule
