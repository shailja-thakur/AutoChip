module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [2:0] state;
reg [7:0] reg_in;
reg is_msg_start;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        reg_in <= 0;
        is_msg_start <= 0;
    end else begin
        case (state)
            0: begin
                if (in[3] == 1) begin
                    state <= 1;
                    reg_in <= in;
                    is_msg_start <= 1;
                end
            end
            1: begin
                if (is_msg_start) begin
                    reg_in <= {reg_in[6:0], in};
                    state <= 2;
                end else begin
                    state <= 0;
                end
            end
            2: begin
                reg_in <= {reg_in[6:0], in};
                state <= 3;
            end
            3: begin
                reg_in <= {reg_in[6:0], in};
                state <= 0;
                if (in[3] == 1) begin
                    is_msg_start <= 1;
                    done <= 1;
                end else begin
                    is_msg_start <= 0;
                    done <= 0;
                end
            end
        endcase
    end
end

endmodule
