module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg [1:0] state;
reg out;

always @(posedge clk or posedge reset) begin
    if(reset)
        state <= 2'b00;
    else if(state == 2'b00) begin
        if(in)
            state <= 2'b01;
        else
            state <= 2'b00;
    end else if(state == 2'b01) begin
        if(in)
            state <= 2'b01;
        else
            state <= 2'b10;
    end else if(state == 2'b10) begin
        if(in)
            state <= 2'b11;
        else
            state <= 2'b00;
    end else begin // state == 2'b11
        if(in)
            state <= 2'b01;
        else
            state <= 2'b10;
    end
end

always @(posedge clk) begin
    if(state == 2'b11)
        out <= 1;
    else
        out <= 0;
end

endmodule
