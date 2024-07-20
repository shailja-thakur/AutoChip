module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    reg [1:0] state;

    always @(posedge clock) begin
        case(state)
            2'b00:
                if (a == 1'b0) begin
                    p <= 1'b0;
                    q <= 1'b0;
                end
                else if (a == 1'b1) begin
                    state <= 2'b01;
                end
            2'b01:
                p <= 1'b1;
                q <= 1'b0;
                state <= 2'b10;
            2'b10:
                if (a == 1'b0) begin
                    p <= 1'b0;
                    q <= 1'b1;
                end
                else if (a == 1'b1) begin
                    state <= 2'b11;
                end
            2'b11:
                p <= 1'b1;
                q <= 1'b1;
                state <= 2'b00;
        endcase
    end

endmodule
