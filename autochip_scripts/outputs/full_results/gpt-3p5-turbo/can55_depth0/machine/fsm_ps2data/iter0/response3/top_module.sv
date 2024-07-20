module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
	
reg [1:0] state;
reg [23:0] shift_reg;

always @(posedge clk)
begin
    if (reset)
    begin
        state <= 2'b00;
        shift_reg <= 24'h000000;
        done <= 0;
    end
    else
    begin
        case (state)
            2'b00: // BYTE1
            begin
                if (in[2] == 1'b1)
                    state <= 2'b01; // BYTE2
                else
                    state <= 2'b00; // BYTE1
            end
            
            2'b01: // BYTE2
            begin
                state <= 2'b10; // BYTE3
            end
            
            2'b10: // BYTE3
            begin
                state <= 2'b11; // DONE
            end
            
            2'b11: // DONE
            begin
                if (in[2] == 1'b0)
                    state <= 2'b00; // BYTE1
                else
                    state <= 2'b11; // DONE
            end
        endcase
    end
end

always @(posedge clk)
begin
    if (reset)
    begin
        out_bytes <= 24'h000000;
    end
    else if (state == 2'b11)
    begin
        out_bytes <= shift_reg;
    end
    else
    begin
        shift_reg <= {shift_reg[15:0], in};
    end
end

always @*
begin
    if (state == 2'b11)
        done = 1;
    else
        done = 0;
end

endmodule
