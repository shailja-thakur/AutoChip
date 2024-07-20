module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

localparam S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
reg [1:0] state, next_state;

always @(posedge clk, negedge aresetn) begin
    if (!aresetn) begin
        state <= S0;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        S0: begin
            next_state = (x == 1'b1) ? S1 : S0;
            z = 1'b0;
        end
        S1: begin
            next_state = (x == 1'b0) ? S2 : S1;
            z = 1'b0;
        end
        S2: begin
            next_state = (x == 1'b1) ? S3 : S0;
            z = 1'b0;
        end
        S3: begin
            next_state = (x == 1'b1) ? S3 : S0;
            z = 1'b1;
        end
        default: begin
            next_state = S0;
            z = 1'b0;
        end
    endcase
end

endmodule
