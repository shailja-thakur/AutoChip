module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

localparam S0 = 2'b00, S1 = 2'b01, S2 = 2'b11, S3 = 2'b10;
reg [1:0] state, next_state;

always @(posedge clk, negedge aresetn) begin
    if (~aresetn) begin
        state <= S0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    z = 0;
    case (state)
        S0: begin
            if (x == 1'b0)
                next_state = S0;
            else
                next_state = S1;
        end
        S1: begin
            if (x == 1'b0)
                next_state = S0;
            else
                next_state = S2;
        end
        S2: begin
            if (x == 1'b0) begin
                next_state = S0;
                z = 1;
            end
            else begin
                next_state = S3;
            end
        end
        S3: begin
            if (x == 1'b0)
                next_state = S0;
            else
                next_state = S2;
        end
        default: begin
            next_state = S0;
        end
    endcase
end

endmodule
