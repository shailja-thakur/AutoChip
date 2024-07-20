module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [1:0] state, next_state;
    reg [23:0] shift_reg;
    reg [1:0] byte_counter;

    // State encoding
    localparam WAIT_FOR_START = 2'b00;
    localparam BYTE1 = 2'b01;
    localparam BYTE2 = 2'b10;
    localparam BYTE3 = 2'b11;

    // State transitions
    always @ (posedge clk) begin
        if (reset) begin
            state <= WAIT_FOR_START;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic and output logic
    always @ (*) begin
        done = 0;
        next_state = state;
        
        case (state)
            WAIT_FOR_START: begin
                if (in[3] == 1) begin
                    next_state = BYTE1;
                end
            end
            
            BYTE1: begin
                next_state = BYTE2;
            end
            
            BYTE2: begin
                next_state = BYTE3;
            end
            
            BYTE3: begin
                next_state = WAIT_FOR_START;
                done = 1;
            end
        endcase
    end

    // Data path logic
    always @ (posedge clk) begin
        if (reset) begin
            shift_reg <= 24'b0;
            out_bytes <= 24'b0;
            byte_counter <= 2'b0;
        end else begin
            case (state)
                WAIT_FOR_START: begin
                    byte_counter <= 0;
                    shift_reg <= 24'b0;
                end
                
                BYTE1: begin
                    shift_reg[23:16] <= in;
                    byte_counter <= byte_counter + 1;
                end
                
                BYTE2: begin
                    shift_reg[15:8] <= in;
                    byte_counter <= byte_counter + 1;
                end
                
                BYTE3: begin
                    shift_reg[7:0] <= in;
                    byte_counter <= byte_counter + 1;
                end
            endcase
            
            if (done) begin
                out_bytes <= shift_reg;
            end
        end
    end
endmodule
