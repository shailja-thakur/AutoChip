module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State encoding
    typedef enum reg [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE  = 2'b11
    } state_t;
    
    reg [1:0] current_state, next_state;
    reg [23:0] shift_reg;

    // State transition logic
    always @(*) begin
        case (current_state)
            BYTE1: begin
                if (in[2]) 
                    next_state = BYTE2;
                else 
                    next_state = BYTE1;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = DONE;
            end
            DONE: begin
                if (in[2])
                    next_state = DONE;
                else 
                    next_state = BYTE1;
            end
            default: begin
                next_state = BYTE1;
            end
        endcase
    end

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= BYTE1;
        end else begin
            current_state <= next_state;
        end
    end

    // Output and register update logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= 24'b0;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            case (current_state)
                BYTE1: begin
                    if (in[2]) begin
                        shift_reg <= {shift_reg[15:0], in};
                    end
                end
                
                BYTE2: begin
                    shift_reg <= {shift_reg[15:0], in};
                end
                
                BYTE3: begin
                    shift_reg <= {shift_reg[15:0], in};
                end
                
                DONE: begin
                    out_bytes <= shift_reg;
                    done <= 1'b1;
                end
                
                default: begin
                    shift_reg <= shift_reg;
                end
            endcase
            
            if (current_state != DONE) begin
                done <= 1'b0;
            end
        end
    end
endmodule
