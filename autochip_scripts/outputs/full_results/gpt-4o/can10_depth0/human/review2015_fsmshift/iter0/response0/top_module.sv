module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [2:0] count;
    reg state;

    // State Definitions
    localparam IDLE = 1'b0;
    localparam SHIFTING = 1'b1;

    // State Machine
    always @(posedge clk) begin
        if (reset) begin
            count <= 3'd0;
            shift_ena <= 1'b1;
            state <= SHIFTING;
        end
        else begin
            case(state)
                IDLE: begin
                    shift_ena <= 1'b1;
                    state <= SHIFTING;
                    count <= 3'd0;
                end
                
                SHIFTING: begin
                    if (count < 3'b100) begin
                        shift_ena <= 1'b1;
                        count <= count + 1;
                    end
                    else begin
                        shift_ena <= 1'b0;
                        state <= IDLE;
                    end
                end
                
                default: begin
                    shift_ena <= 1'b0;
                    state <= IDLE;
                end
            endcase
        end
    end
    
endmodule
