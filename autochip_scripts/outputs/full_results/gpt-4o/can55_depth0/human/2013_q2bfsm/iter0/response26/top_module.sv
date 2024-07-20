module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // Define states
    typedef enum reg [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100
    } state_t;
    
    state_t state, next_state;
    reg [1:0] counter;    // For tracking y input within two clock cycles

    // State transition and output logic
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= A;
            f <= 0;
            g <= 0;
            counter <= 2'b00;
        end
        else begin
            state <= next_state;
            case (next_state)
                A: begin
                    f <= 1'b0;
                    g <= 1'b0;
                    counter <= 2'b00;
                end
                B: begin
                    f <= 1'b1;
                end
                C: begin
                    f <= 1'b0;
                end
                D: begin
                    counter <= 2'b00;
                    g <= 1'b1;
                end
                E: begin
                    if (y == 1'b1) begin
                        g <= 1'b1;
                    end
                    else if (counter == 2'b10) begin
                        g <= 1'b0;
                    end
                    else begin
                        counter <= counter + 1;
                    end
                end
            endcase
        end
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            A: next_state = resetn ? B : A;
            B: next_state = C;
            C: next_state = (x == 1'b1) ? D : A;
            D: if(x == 1'b0) next_state = E; else next_state = A;
            E: next_state = (g == 1'b0 || counter == 2'b10) ? A : E;
            default: next_state = A;
        endcase
    end

endmodule
