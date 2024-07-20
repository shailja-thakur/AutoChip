module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [2:0] state;
reg [7:0] byte_count;
reg [7:0] byte_1;
reg [7:0] byte_2;
reg [7:0] byte_3;

always @(posedge clk) begin
    if (reset) begin
        state <= 0;
        byte_count <= 0;
        byte_1 <= 0;
        byte_2 <= 0;
        byte_3 <= 0;
        done <= 0;
    end
    else begin
        case (state)
            0: begin
                if (in[3] == 1) begin
                    state <= 1;
                    byte_count <= 1;
                    byte_1 <= in;
                end
            end
            1: begin
                byte_count <= byte_count + 1;
                byte_2 <= in;
                state <= 2;
            end
            2: begin
                byte_count <= byte_count + 1;
                byte_3 <= in;
                state <= 3;
            end
            3: begin
                byte_count <= 0;
                state <= 0;
                if (in[3] == 1) begin
                    byte_count <= 1;
                    byte_1 <= in;
                end
                done <= 1;
            end
        endcase
    end
end

endmodule
