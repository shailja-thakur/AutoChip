module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;

localparam [1:0]
    S0 = 2'b00, // Initial state
    S1 = 2'b01, // Detected '1'
    S2 = 2'b10; // Detected '01'

always @(posedge clk, negedge aresetn) begin
    if (!aresetn)
        state <= S0;
    else
        state <= next_state;
end

always @(*) begin
    next_state = state;
    z = 1'b0;
    case (state)
        S0: begin
            if (x)
                next_state = S1;
        end
        S1: begin
            if (!x)
                next_state = S2;
            else
                next_state = S1;
        end
        S2: begin
            if (x)
                next_state = S1;
            else begin
                next_state = S0;
                z = 1'b1;
            end
        end
    endcase
end

endmodule
