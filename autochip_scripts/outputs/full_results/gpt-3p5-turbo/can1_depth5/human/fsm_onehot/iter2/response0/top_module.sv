module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);
    
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

    assign next_state = next_state_reg;
    assign out1 = out1_reg;
    assign out2 = out2_reg;

endmodule
