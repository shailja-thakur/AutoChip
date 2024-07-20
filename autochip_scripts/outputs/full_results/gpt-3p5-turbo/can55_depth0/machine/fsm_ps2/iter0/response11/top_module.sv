module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    // Define states
    parameter BYTE1 = 0;
    parameter BYTE2 = 1;
    parameter BYTE3 = 2;
    parameter DONE = 3;
    
    // Define current state
    reg [1:0] state;
    
    // Next state logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
        end else begin
            case (state)
                BYTE1: begin
                    if (in[2]) begin
                        state <= BYTE2;
                    end else begin
                        state <= BYTE1;
                    end
                end
                
                BYTE2: begin
                    state <= BYTE3;
                end
                
                BYTE3: begin
                    state <= DONE;
                end
                
                DONE: begin
                    if (in[2]) begin
                        state <= BYTE2;
                    end else begin
                        state <= BYTE1;
                    end
                end
                
                default: state <= BYTE1;
            endcase
        end
    end
    
    // Output logic
    assign done = (state == DONE);
    
endmodule
