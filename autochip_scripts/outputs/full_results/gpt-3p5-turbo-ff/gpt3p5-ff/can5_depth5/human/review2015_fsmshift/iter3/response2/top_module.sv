module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [1:0] state;
    reg [1:0] next_state;
    reg [3:0] shift_ena_counter;
    
    parameter IDLE = 2'b00;
    parameter SET_SHIFT_ENA = 2'b01;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            shift_ena_counter <= 4'b0;
        end else begin
            state <= next_state;
            
            case (state)
                IDLE: begin
                    if (shift_ena_counter < 4) begin
                        shift_ena_counter <= shift_ena_counter + 1;
                    end else begin
                        shift_ena_counter <= 4'b0;
                    end
                end
                SET_SHIFT_ENA: begin
                    shift_ena_counter <= 4'b0;
                end
                default: begin
                    shift_ena_counter <= 4'b0;
                end
            endcase
        end
    end
    
    always @(state) begin
        case (state)
            IDLE: begin
                if (reset) begin
                    next_state = SET_SHIFT_ENA;
                    shift_ena = 1'b1;
                end else begin
                    next_state = IDLE;
                    shift_ena = (shift_ena_counter < 4) ? 1'b1 : 1'b0;
                end
            end
            SET_SHIFT_ENA: begin
                next_state = IDLE;
                shift_ena = (shift_ena_counter < 4) ? 1'b1 : 1'b0;
            end
            default: begin
                next_state = IDLE;
                shift_ena = 1'b0;
            end
        endcase
    end

endmodule
