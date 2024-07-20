module top_module(
    input wire clk,
    input wire reset,
    output reg shift_ena);

    reg [1:0] state;
    reg [1:0] next_state;
    reg [1:0] count;
    
    parameter IDLE = 2'b00;
    parameter SET_SHIFT_ENA = 2'b01;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            count <= 2'b00;
            shift_ena <= 1'b1;
        end else begin
            state <= next_state;
            count <= count + 1;
            
            case (state)
                IDLE: begin
                    if (count < 2'd3) begin
                        next_state = SET_SHIFT_ENA;
                    end else begin
                        next_state = IDLE;
                    end
                    shift_ena <= (count < 2'd3);
                end
                SET_SHIFT_ENA: begin
                    next_state = IDLE;
                    shift_ena <= 1'b0;
                end
                default: begin
                    next_state = IDLE;
                    shift_ena <= 1'b0;
                end
            endcase
        end
    end

endmodule
