module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam IDLE  = 3'b000;
localparam START = 3'b001;
localparam DATA  = 3'b010;
localparam STOP  = 3'b011;
localparam ERROR = 3'b100;

reg [2:0] state, next_state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_reg <= 0;
        done <= 0;
        out_byte <= 0;
    end
    else begin
        state <= next_state;
        
        case (state)
            IDLE: begin
                if (in == 0) begin // Start bit detected
                    next_state <= START;
                    bit_count <= 0;
                    data_reg <= 0;
                end
                else begin
                    next_state <= IDLE;
                end
                done <= 0;
            end
            
            START: begin
                if (in == 0) begin // Still start bit
                    next_state <= DATA;
                end
                else begin // Start bit ended too early
                    next_state <= ERROR;
                end
            end
            
            DATA: begin
                data_reg[bit_count] <= in; // Capture data bit
                bit_count <= bit_count + 1;
                if (bit_count == 7) begin
                    next_state <= STOP;
                end
                else begin
                    next_state <= DATA;
                end
            end
            
            STOP: begin
                if (in == 1) begin // Stop bit detected
                    next_state <= IDLE;
                    out_byte <= data_reg;
                    done <= 1;
                end
                else begin // Stop bit not detected
                    next_state <= ERROR;
                end
            end
            
            ERROR: begin
                if (in == 1) begin // Look for start of next byte
                    next_state <= IDLE;
                end
                else begin
                    next_state <= ERROR;
                end
                done <= 0;
            end
        endcase
    end
end

endmodule
