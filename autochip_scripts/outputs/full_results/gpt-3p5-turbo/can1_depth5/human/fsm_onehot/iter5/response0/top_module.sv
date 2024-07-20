module top_module (
    input wire clk,
    input wire reset,
    input wire in,
    input wire [9:0] state,
    output wire [9:0] next_state,
    output wire out1,
    output wire out2
);

    reg [9:0] next_state_reg;
    reg out1_reg;
    reg out2_reg;

    always @* begin
        case (state)
        10'b0000000001: begin
            if (in == 1'b0) begin
                next_state_reg = 10'b0000000001;
            end else begin
                next_state_reg = 10'b0000000010;
            end
        end
        10'b0000000010: begin
            if (in == 1'b0) begin
                next_state_reg = 10'b0000000001;
            end else begin
                next_state_reg = 10'b0000000011;
            end
        end
        10'b0000000011: begin
            if (in == 1'b0) begin
                next_state_reg = 10'b0000000001;
            end else begin
                next_state_reg = 10'b0000000100;
            end
        end
        10'b0000000100: begin
            if (in == 1'b0) begin
                next_state_reg = 10'b0000000001;
            end else begin
                next_state_reg = 10'b0000000101;
            end
        end
        10'b0000000101: begin
            if (in == 1'b0) begin
                next_state_reg = 10'b0000001000;
            end else begin
                next_state_reg = 10'b0000000110;
            end
        end
        10'b0000000110: begin
            if (in == 1'b0) begin
                next_state_reg = 10'b0000001001;
            end else begin
                next_state_reg = 10'b0000000111;
            end
        end
        10'b0000000111: begin
            if (in == 1'b0) begin
                next_state_reg = 10'b0000000001;
            end else begin
                next_state_reg = 10'b0000000111;
            end
        end
        10'b0000001000: begin
            if (in == 1'b0) begin
                next_state_reg = 10'b0000000001;
            end else begin
                next_state_reg = 10'b0000000010;
            end
        end
        10'b0000001001: begin
            if (in == 1'b0) begin
                next_state_reg = 10'b0000000001;
            end else begin
                next_state_reg = 10'b0000000010;
            end
        end
        10'b0000001010: begin
            if (in == 1'b0) begin
                next_state_reg = 10'b0000000001;
            end else begin
                next_state_reg = 10'b0000000010;
            end
        end
        default: begin
            next_state_reg = 10'b0000000000;
        end
        endcase
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            next_state <= 10'b0000000000;
            out1 <= 1'b0;
            out2 <= 1'b0;
        end else begin
            next_state <= next_state_reg;
            out1 <= out1_reg;
            out2 <= out2_reg;
        end
    end

    always @* begin
        case (state)
        10'b0000000111: begin
            out1_reg = 1'b0;
            out2_reg = 1'b1;
        end
        10'b0000001000: begin
            out1_reg = 1'b1;
            out2_reg = 1'b0;
        end
        10'b0000001001: begin
            out1_reg = 1'b1;
            out2_reg = 1'b1;
        end
        default: begin
            out1_reg = 1'b0;
            out2_reg = 1'b0;
        end
        endcase
    end

endmodule
