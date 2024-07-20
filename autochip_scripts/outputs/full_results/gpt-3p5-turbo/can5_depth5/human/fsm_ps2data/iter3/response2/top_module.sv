module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

reg [7:0] prev_in = 8'h00;
reg [7:0] prev_prev_in = 8'h00;
reg [23:0] message;
reg [2:0] state = 0;
reg [1:0] counter = 0;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        message <= 0;
        prev_in <= 8'h00;
        prev_prev_in <= 8'h00;
        counter <= 0;
    end else begin
        prev_prev_in <= prev_in;
        prev_in <= in;
        if (state == 0) begin
            if (in[3] == 1) begin
                state <= 1;
            end
        end else if (state == 1) begin
            if (prev_in[3] == 1) begin
                state <= 2;
            end else begin
                state <= 0;
            end
        end else if (state == 2) begin
            if (prev_in[3] == 1) begin
                message <= {prev_prev_in, prev_in, in};
                counter <= counter + 1;
                if (counter == 1) begin
                    state <= 3;
                end else begin
                    state <= 0;
                end
            end else begin
                state <= 0;
            end
        end else if (state == 3) begin
            counter <= counter + 1;
            if (counter == 1) begin
                state <= 0;
                counter <= 0;
            end
        end
    end
end

assign done = (state == 3);
assign out_bytes = done ? message : 24'hzzzzzz;

endmodule
