module top_module(
    input clk,
    input reset,
    output shift_ena);
    
    reg [3:0] count;
    reg shift_ena;
    reg [1:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 4'b0000;
            shift_ena <= 1'b0;
            state <= 2'b00;
        end else begin
            case(state)
                2'b00: begin
                    if (/*Add your bit pattern condition here*/) begin
                        state <= 2'b01;
                        count <= 4'b0000;
                        shift_ena <= 1'b1;
                    end else begin
                        state <= 2'b00;
                    end
                end
                2'b01: begin
                    if (count < 4) begin
                        count <= count + 1;
                    end else begin
                        state <= 2'b00;
                        shift_ena <= 1'b0;
                    end
                end
                default: begin
                    state <= 2'b00;
                    shift_ena <= 1'b0;
                end
            endcase
        end
    end
endmodule
