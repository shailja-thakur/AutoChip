module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

// State definitions
parameter IDLE = 2'b00;
parameter START_BIT = 2'b01;
parameter DATA_BIT = 2'b10;
parameter STOP_BIT = 2'b11;

reg [1:0] state = IDLE;  // Current state
reg [7:0] data_reg;     // Data register to store received data byte

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        data_reg <= 8'b0;
    end else begin
        case (state)
            
            IDLE: begin
                if (in == 1'b0) begin
                    state <= START_BIT;
                    data_reg <= 8'b0;
                end
            end
            
            START_BIT: begin
                state <= DATA_BIT;
            end
            
            DATA_BIT: begin
                data_reg <= {data_reg[6:0], in};
                state <= (data_reg == 8'hFF) ? STOP_BIT : DATA_BIT;
            end
            
            STOP_BIT: begin
                if (in == 1'b1) begin
                    out_byte <= data_reg;
                    state <= IDLE;
                end
            end
            
        endcase
        
        done <= (state == STOP_BIT) ? 1'b1 : 1'b0;
    end
end

endmodule
