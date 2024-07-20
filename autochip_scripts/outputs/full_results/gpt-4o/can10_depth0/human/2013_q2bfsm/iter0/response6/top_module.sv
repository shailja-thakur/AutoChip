module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // State encoding
    typedef enum logic [2:0] {
        A,
        B,
        C,
        D,
        E,
        F,
        G
    } state_t;

    state_t state, next_state;

    // State transition logic (combinational)
    always @* begin
        // default values
        f = 0;
        g = 0;
        
        case (state)
            A: begin
                next_state = resetn ? B : A;
            end
            B: begin
                f = 1;
                next_state = C;
            end
            C: begin
                next_state = x ? D : C;
            end
            D: begin
                next_state = !x ? E : D;
            end
            E: begin
                next_state = x ? F : E;
            end
            F: begin
                g = 1;
                next_state = (y ? G : F);
            end
            G: begin
                g = 1;
                next_state = G;
            end
            default: next_state = A;
        endcase
    end

    // State progression logic (sequential)
    always @(posedge clk or negedge resetn) begin
        if(!resetn)
            state <= A;
        else
            state <= next_state;
    end

    // G output logic
    wire [1:0] y_counter;
    reg y_flag;

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            y_counter <= 2'b0;
            y_flag <= 1'b0;
        end else if (state == F) begin
            if (y_counter < 2) begin
                y_counter <= y_counter + 1;
                if (y)
                    y_flag <= 1'b1;
            end
        end else begin
            y_counter <= 2'b0;
            y_flag <= 1'b0;
        end
    end

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            g <= 1'b0;
        end else if (state == G || (state == F && y_flag)) begin
            g <= 1'b1;
        end else if (state == F && y_counter == 2'b10 && !y_flag) begin
            g <= 1'b0;
        end
    end
    
endmodule
