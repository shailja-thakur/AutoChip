module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

    reg [3:0] data;

    // Flop1
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            data[0] <= 1'b0;
        else
            data[0] <= in;
    end

    // Flop2
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            data[1] <= 1'b0;
        else
            data[1] <= data[0];
    end

    // Flop3
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            data[2] <= 1'b0;
        else
            data[2] <= data[1];
    end

    // Flop4
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            data[3] <= 1'b0;
        else
            data[3] <= data[2];
    end

    assign out = data[3];

endmodule
