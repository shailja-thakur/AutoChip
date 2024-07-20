module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

localparam [1:0] 
    S0 = 2'b00, // Initial state
    S1 = 2'b01, // Seen '1'
    S2 = 2'b10; // Seen '01'

reg [1:0] current_state, next_state;

always @(posedge clk, negedge aresetn) begin
    if(!aresetn) begin
        current_state <= S0;
        z <= 0;
    end
    else begin
        current_state <= next_state;
        z <= (current_state == S2) ? 1 : 0; // Assert z when in S2 state
    end
end

always @(*) begin
    case(current_state)
        S0: begin
            if(x == 1'b1)
                next_state = S1;
            else
                next_state = S0;
        end
        S1: begin
            if(x == 1'b0)
                next_state = S2;
            else
                next_state = S1;
        end
        S2: begin
            if(x == 1'b1)
                next_state = S1;
            else
                next_state = S0;
        end
        default: next_state = S0;
    endcase
end

endmodule
