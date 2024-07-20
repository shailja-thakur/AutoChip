module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

    reg [23:0] reg_bytes;  // Register to store the shifted input
    
    // State definitions
    localparam [1:0] BYTE1 = 2'b00;
    localparam [1:0] BYTE2 = 2'b01;
    localparam [1:0] BYTE3 = 2'b10;
    localparam [1:0] DONE = 2'b11;
    
    reg [1:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;  // Reset state to BYTE1
            done <= 0;  // Reset done signal
            reg_bytes <= 0;  // Reset register
        end else begin
            case (state)
                BYTE1: begin
                    if (in[2]) begin
                        state <= BYTE2;
                    end else begin
                        state <= BYTE1;
                    end
                    reg_bytes <= {reg_bytes[15:0], in};
                end
                
                BYTE2: begin
                    if (in[2]) begin
                        state <= BYTE3;
                    end else begin
                        state <= BYTE1;
                    end
                    reg_bytes <= {reg_bytes[15:0], in};
                end
                
                BYTE3: begin
                    if (in[2]) begin
                        state <= DONE;
                    end else begin
                        state <= BYTE1;
                    end
                    reg_bytes <= {reg_bytes[15:0], in};
                end
                
                DONE: begin
                    if (in[2]) begin
                        state <= BYTE1;
                    end else begin
                        state <= BYTE1;
                    end
                end
            endcase
        end
    end
    
    // Assign the output
    assign out_bytes = (done) ? reg_bytes : 24'b0;
    assign done = (state == DONE) ? 1'b1 : 1'b0;
    
endmodule
