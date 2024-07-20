module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    reg [7:0] state;

    // State definitions
    localparam BYTE1 = 0;
    localparam BYTE2 = 1;
    localparam BYTE3 = 2;
    localparam DONE = 3;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
            done <= 0;
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
            endcase
        end
    end
    
    always @(posedge clk) begin
        if (state == DONE) begin
            done <= 1;
        end else begin
            done <= 0;
        end
    end

endmodule
