module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

reg [2:0] state;
reg [7:0] data;
reg start_found;
reg [2:0] count;

parameter S0 = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;
parameter S3 = 3'b011;
parameter S4 = 3'b100;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= S0;
    else
        case(state)
            S0: begin
                if (in)
                    state <= S1;
            end
            S1: begin
                state <= S2;
                start_found <= 1'b1;
                count <= 3'b000;
                data <= 8'b00000000;
            end
            S2: begin
                if (count != 3'b111) begin
                    state <= S2;
                    count <= count + 1;
                    data <= {data[6:0], in};
                end
                else
                    state <= S3;
            end
            S3: begin
                if (~in)
                    state <= S4;
                else
                    state <= S3;
            end
            S4: begin
                if (~in) begin
                    state <= S0;
                    start_found <= 1'b0;
                end
                else if (start_found)
                    state <= S4;
            end
        endcase
    end
end

assign out_byte = data;
assign done = (state == S4);

endmodule
