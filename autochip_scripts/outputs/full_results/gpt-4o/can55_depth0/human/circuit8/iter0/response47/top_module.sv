module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    reg [1:0] state;

    always @(posedge clock) begin
        if (a == 1) begin
            state <= 2'b11;
            p <= 1;
        end else begin
            state <= 2'b00;
            p <= 0;
        end
    end

    always @(negedge clock) begin
        if (state == 2'b11) begin
            q <= 1;
        end else begin
            q <= 0;
        end
    end

endmodule
