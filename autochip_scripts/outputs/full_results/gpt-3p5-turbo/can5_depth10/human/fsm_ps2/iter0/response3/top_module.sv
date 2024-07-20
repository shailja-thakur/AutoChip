module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

// States
parameter [2:0] START = 3'b000;
parameter [2:0] CHECK_BYTE1 = 3'b001;
parameter [2:0] CHECK_BYTE2 = 3'b010;
parameter [2:0] CHECK_BYTE3 = 3'b011;

reg [2:0] state;
reg done;

always @(posedge clk) begin
    if (reset) begin
        state <= START;
        done <= 0;
    end else begin
        case (state)
            START: begin
                if (in[3] == 1) begin
                    state <= CHECK_BYTE1;
                end else begin
                    state <= START;
                end
            end
            CHECK_BYTE1: begin
                if (in[3] == 1) begin
                    state <= CHECK_BYTE2;
                end else begin
                    state <= START;
                end
            end
            CHECK_BYTE2: begin
                if (in[3] == 1) begin
                    state <= CHECK_BYTE3;
                end else begin
                    state <= START;
                end
            end
            CHECK_BYTE3: begin
                if (in[3] == 1) begin
                    state <= CHECK_BYTE1;
                    done <= 1;
                end else begin
                    state <= START;
                end
            end
        endcase
    end
end

endmodule
