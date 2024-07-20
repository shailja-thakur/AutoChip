module top_module (
    input clk,
    input resetn,
    input in,
    output out
);

    reg [3:0] shiftreg;

    always @(posedge clk) begin
        if (!resetn) begin
            shiftreg <= 4'b0;
        end
        else begin
            shiftreg <= {shiftreg[2:0], in};
        end
    end

    assign out = shiftreg[3];

endmodule
