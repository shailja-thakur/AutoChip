module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;
parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

always @(posedge clk, negedge aresetn) begin
    if (!aresetn)
        state <= S0;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        S0: begin
            z = 0;
            if (x)
                next_state = S1;
            else
                next_state = S0;
        end
        S1: begin
            z = 0;
            if (x)
                next_state = S2;
            else
                next_state = S0;
        end
        S2: begin
            z = 1;
            if (x)
                next_state = S3;
            else
                next_state = S0;
        end
        S3: begin
            z = 0;
            if (x)
                next_state = S3;
            else
                next_state = S0;
        end
    endcase
end

endmodule
