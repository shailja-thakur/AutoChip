module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;

always @(posedge clk, negedge aresetn) begin
    if (!aresetn) begin
        state <= 2'b00;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        2'b00: // S
            if (x == 1'b0) begin
                next_state = 2'b00;
            end else begin
                next_state = 2'b01;
            end
        2'b01: // S1
            if (x == 1'b0) begin
                next_state = 2'b10;
            end else begin
                next_state = 2'b01;
            end
        2'b10: // S10
            if (x == 1'b0) begin
                next_state = 2'b00;
            end else begin
                next_state = 2'b01;
            end
        default:
            next_state = 2'b00;
    endcase
end

always @(*) begin
    case (state)
        2'b00: // S
            z = 1'b0;
        2'b01: // S1
            z = 1'b0;
        2'b10: // S10
            z = x;
        default:
            z = 1'b0;
    endcase
end

endmodule
