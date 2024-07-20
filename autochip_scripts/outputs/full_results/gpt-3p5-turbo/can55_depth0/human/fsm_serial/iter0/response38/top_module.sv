module top_module (
    input clk,
    input in,
    input reset,
    output done
);

    reg [3:0] state;

    // State Constants
    localparam IDLE = 4'd0;
    localparam START_BIT = 4'd1;
    localparam DATA_BITS = 4'd2;
    localparam STOP_BIT = 4'd3;
    
    // Data storage
    reg [7:0] data_bits;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            data_bits <= 8'b0;
            done <= 1'b0;
        end else begin
            case (state)
                
                IDLE: begin
                    if (in == 1'b0) begin
                        state <= START_BIT;
                    end
                end
                
                START_BIT: begin
                    state <= DATA_BITS;
                end
                
                DATA_BITS: begin
                    data_bits <= {data_bits[6:0], in};
                    
                    if ($unsigned(data_bits) == 8'hFF) begin
                        state <= STOP_BIT;
                    end
                end
                
                STOP_BIT: begin
                    if (in == 1'b1) begin
                        state <= IDLE;
                        done <= 1'b1;
                    end
                end
                
            endcase
        end
    end

endmodule
