module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    // FSM states
    typedef enum logic [2:0] {
        S0, S1, S2, S3, S4, S5, COUNTING, DONE
    } state_t;
    state_t state, next_state;

    reg [3:0] shift_reg;
    reg [12:0] cycle_count;
    reg [3:0] delay;

    // State Transition
    always @(posedge clk) begin
        if (reset) begin
            state <= S0;
            cycle_count <= 13'd0;
            delay <= 4'd0;
            done <= 1'b0;
            counting <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    // Next State Logic
    always @* begin
        next_state = state;
        case(state)
            S0: if (data == 1'b1) next_state = S1;
            S1: if (data == 1'b1) next_state = S2; else next_state = S0;
            S2: if (data == 1'b0) next_state = S3; else next_state = S0;
            S3: if (data == 1'b1) next_state = S4; else next_state = S0;
            S4: next_state = S5;
            S5: if (cycle_count == 0) next_state = COUNTING; else next_state = S5;
            COUNTING: if (cycle_count == 1) next_state = DONE;
            DONE: if (ack == 1'b1) next_state = S0;
            default: next_state = S0;
        endcase
    end
    
    always @(posedge clk) begin
        if(reset) begin
            shift_reg <= 4'b0;
            count <= 4'bZ;
        end else begin
            case(state)
                S4: begin
                        shift_reg <= {shift_reg[2:0], data}; // Shift in the 4-bit delay
                        if (cycle_count != 5) 
                            cycle_count <= cycle_count + 1;
                        else begin
                            delay <= shift_reg;
                            cycle_count <= 0;
                        end
                     end
                COUNTING: begin
                        count <= cycle_count / 1000;
                        cycle_count <= cycle_count - 1;
                        counting <= 1'b1;
                        done <= 1'b0;
                    end
                DONE: begin
                        done <= 1'b1;
                        counting <= 1'b0;
                    end
                default: begin
                        counting <= 1'b0;
                        done <= 1'b0;
                     end
            endcase
        end
    end

    // Counter logic
    always @(posedge clk) begin
        if(state == COUNTING) begin
            if(cycle_count == 0) begin
                cycle_count <= (delay + 1) * 1000 - 1;
            end
        end
    end

endmodule
