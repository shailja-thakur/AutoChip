module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output reg done
);
 
reg [7:0] prev_in;
reg [7:0] prev_prev_in;
reg [23:0] message;
reg [2:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        done <= 0; 
        message <= 0;
        prev_in <= 0;
        prev_prev_in <= 0;
    end else begin
        case (state)
            0: begin
                if (in[3] == 1) begin
                    prev_prev_in <= prev_in;
                    prev_in <= in;
                    state <= 1;
                end
            end
            1: begin
                if (in[3] == 1) begin
                    prev_prev_in <= prev_in;
                    prev_in <= in;
                    state <= 2;
                end else begin
                    prev_prev_in <= prev_in;
                    prev_in <= in;
                    state <= 0;
                end
            end
            2: begin
                if (in[3] == 1) begin
                    prev_prev_in <= prev_in;
                    prev_in <= in;
                    state <= 3;
                end else begin
                    prev_prev_in <= prev_in;
                    prev_in <= in;
                    state <= 0;
                end
            end
            3: begin
                if (in[3] == 1) begin
                    prev_prev_in <= prev_in;
                    prev_in <= in;
                    state <= 2;
                end else begin
                    prev_prev_in <= prev_in;
                    prev_in <= in;
                    state <= 0;
                    message <= {prev_prev_in, prev_in, in};
                    done <= 1;
                end
            end
            default: state <= 0;
        endcase
    end
end
 
assign out_bytes = done ? message : 24'hzzzzzz;

endmodule
