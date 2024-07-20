module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output reg B3_next,
    output reg S_next,
    output reg S1_next,
    output reg Count_next,
    output reg Wait_next,
    output reg done,
    output reg counting,
    output reg shift_ena
);
    
    reg [9:0] next_state;
    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            next_state <= 10'b0;
            done <= 1'b0;
            counting <= 1'b0;
            shift_ena <= 1'b0;
        end else begin
            case (state)
                10'b0000000001: begin // S
                    if (d == 1'b0) begin
                        S_next <= 1'b1;
                        next_state <= 10'b0000000010; // S1
                    end
                end
                10'b0000000010: begin // S1
                    if (d == 1'b1) begin
                        S1_next <= 1'b1;
                        next_state <= 10'b0000001100; // B0
                    end
                end
                10'b0000001100: begin // B0
                    shift_ena <= 1'b1;
                    next_state <= 10'b0000001101; // B1
                end
                10'b0000001101: begin // B1
                    shift_ena <= 1'b1;
                    next_state <= 10'b0000001110; // B2
                end
                10'b0000001110: begin // B2
                    shift_ena <= 1'b1;
                    B3_next <= 1'b1;
                    next_state <= 10'b0000001111; // B3
                end
                10'b0000001111: begin // B3
                    if (done_counting == 1'b0) begin
                        Count_next <= 1'b1;
                        next_state <= 10'b0000010000; // Count
                    end
                end
                10'b0000010000: begin // Count
                    counting <= 1'b1;
                    if (done_counting == 1'b1) begin
                        Wait_next <= 1'b1;
                        next_state <= 10'b0000010001; // Wait
                    end
                end
                10'b0000010001: begin // Wait
                    if (ack == 1'b0) begin
                        Wait_next <= 1'b1;
                        next_state <= 10'b0000000001; // S
                    end
                end
                default: begin
                    next_state <= 10'b0;
                    done <= 1'b0;
                    counting <= 1'b0;
                    shift_ena <= 1'b0;
                end
            endcase
        end
    end
    
    always @(state) begin
        case (state)
            10'b0000010001,
            10'b0000010000: done <= 1'b0;
            10'b0000001111,
            10'b0000010000: counting <= 1'b1;
            10'b0000001100,
            10'b0000001101,
            10'b0000001110,
            10'b0000001111: shift_ena <= 1'b1;
            default: begin
                done <= 1'b0;
                counting <= 1'b0;
                shift_ena <= 1'b0;
            end
        endcase
    end
    
    assign B3_next = (state == 10'b0000001110);
    assign S_next = ((state == 10'b0000000001) && (d == 1'b0)) ||
                   ((state == 10'b0000000010) && (d == 1'b0)) ||
                   ((state == 10'b0000001100) && (d == 1'b0)) ||
                   ((state == 10'b0000010001) && (ack == 1'b1));
    assign S1_next = ((state == 10'b0000000001) && (d == 1'b1));
    assign Count_next = ((state == 10'b0000001111) || (state == 10'b0000010000));
    assign Wait_next = ((state == 10'b0000010000) && (done_counting == 1'b1)) ||
                      ((state == 10'b0000010001) && (ack == 1'b0));
    
endmodule
