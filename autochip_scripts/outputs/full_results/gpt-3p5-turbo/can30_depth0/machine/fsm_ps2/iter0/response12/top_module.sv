module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    // Define state variables
    reg [1:0] state;
    
    // Define constants for states
    localparam BYTE1 = 2'b00;
    localparam BYTE2 = 2'b01;
    localparam BYTE3 = 2'b10;
    localparam DONE = 2'b11;
    
    // Define flip-flop for the done signal
    reg done_ff;
    
    // Define next state logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
            done_ff <= 0;
        end else begin
            case (state)
                BYTE1: begin
                    if (in[2] == 1'b1)
                        state <= BYTE2;
                    else
                        state <= BYTE1;
                end
                BYTE2: begin
                    state <= BYTE3;
                end
                BYTE3: begin
                    state <= DONE;
                end
                DONE: begin
                    if (in[2] == 1'b1)
                        state <= BYTE2;
                    else
                        state <= BYTE1;
                end
                default: begin
                    state <= BYTE1;
                end
            endcase
        end
    end
    
    // Define done signal logic
    always @(posedge clk) begin
        case (state)
            DONE: begin
                if (in[2] == 1'b1)
                    done_ff <= 1;
                else
                    done_ff <= 0;
            end
            default: begin
                done_ff <= 0;
            end
        endcase
    end
    
    // Assign done signal
    assign done = done_ff;
    
endmodule
