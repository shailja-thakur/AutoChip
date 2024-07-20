module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    
    reg [1:0] state, next_state;
    reg complement, carry;
    
    localparam S0 = 2'b00,
               S1 = 2'b01;

    always @ (posedge clk or posedge areset) begin
        if (areset) begin
            state <= S0;
            z <= 0;
            complement <= 0;
            carry <= 0;
        end else begin
            state <= next_state;
            z <= complement ? ~x : x;
            if (complement) begin
                z <= carry ? ~x ^ 1'b1 : ~x;
                carry <= carry & x;
            end
            
            if (state == S1) begin
                complement <= 1;
                carry <= 1;
            end
        end
    end
    
    always @ (*) begin
        case (state)
            S0: begin
                if (areset)
                    next_state = S0;
                else
                    next_state = S1;
            end
            
            S1: begin
                if (areset)
                    next_state = S0;
                else
                    next_state = S1;
            end
            
            default: next_state = S0;
        endcase
    end

endmodule
