module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

reg [7:0] first_byte;
reg [7:0] second_byte;
reg [7:0] third_byte;
reg [2:0] state;
reg [1:0] counter;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        first_byte <= 8'h00;
        second_byte <= 8'h00;
        third_byte <= 8'h00;
        counter <= 0;
        out_bytes <= 0;
        done <= 0;
    end else begin
        case(state)
            0: begin
                if (in[3] == 1) begin
                    first_byte <= in;
                    state <= 1;
                    counter <= 0;
                end
            end
            1: begin
                if (in[3] == 1) begin
                    state <= 2;
                end else begin
                    first_byte <= in;
                end
            end
            2: begin
                if (in[3] == 1) begin
                    second_byte <= in;
                    counter <= counter + 1;
                    if (counter == 1) begin
                        state <= 3;
                    end else begin
                        state <= 0;
                    end
                end else begin
                    first_byte <= in;
                end
            end
            3: begin
                counter <= counter + 1;
                if (counter == 2) begin
                    state <= 0;
                    counter <= 0;
                    third_byte <= in;
                    out_bytes <= {first_byte, second_byte, third_byte};
                    done <= 1;
                end
            end
        endcase
    end
end

endmodule
